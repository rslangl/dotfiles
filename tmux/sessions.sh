#!/bin/zsh

# Function to find the i3 IPC socket
find_i3_socket() {
    local socket_dir="/run/user/$(id -u)/i3"
    if [ -d "$socket_dir" ]; then
        local socket_file=$(ls "$socket_dir"/ipc-socket.* 2>/dev/null | head -n 1)
        if [ -S "$socket_file" ]; then
            echo "$socket_file"
            return 0
        fi
    fi
    return 1
}

# Check if i3 is running
#if ! pgrep -x "i3" >/dev/null; then
#  echo "i3 window manager is not running. Please start i3 and try again."
#  exit 1
#fi

# Export I3SOCK to ensure i3-msg can find the correct IPC socket
#export I3SOCK=$(ls /run/user/$(id -u)/i3/ipc-socket.* | head -n 1)
export I3SOCK=$(find_i3_socket)

# Check if the i3 socket exists
if [ ! -S "$I3SOCK" ]; then
  echo "i3 IPC socket not found. Please ensure i3 is running correctly."
  exit 1
fi

# Function to create a tmux session with the provided parameters
create_session() {
  local SESSION_NAME=$1
  local WINDOW_NAME=$2
  local DIR=$3
  local PANE1_CMD=$4
  local PANE2_CMD=$5

  tmux has-session -t $SESSION_NAME 2>/dev/null

  if [ $? != 0 ]; then
    # Create the session and window
    tmux new-session -d -s $SESSION_NAME -n $WINDOW_NAME

    # Change directory in the first pane
    tmux send-keys -t $SESSION_NAME:$WINDOW_NAME "cd $DIR" C-m

    # Split the window vertically
    tmux split-window -h -t $SESSION_NAME:$WINDOW_NAME

    # Split the right pane horizontally
    tmux split-window -v -t $SESSION_NAME:$WINDOW_NAME.1

    # Run the commands in the respective panes
    tmux send-keys -t $SESSION_NAME:$WINDOW_NAME.1 "$PANE1_CMD" C-m
    tmux send-keys -t $SESSION_NAME:$WINDOW_NAME.2 "$PANE2_CMD" C-m

    # Select the left (main) pane
    tmux select-pane -t $SESSION_NAME:$WINDOW_NAME.0
  fi
}

# Function to create i3 workspace and launch tmux session in a new terminal
create_i3_workspace() {
  local WORKSPACE_NUM=$1
  local SESSION_NAME=$2
  local OUTPUT=$3
  local TERMINAL_CMD=${TERMINAL:-st}

  i3-msg -s "$I3SOCK" "workspace number $WORKSPACE_NUM; move workspace to output $OUTPUT; exec $TERMINAL_CMD -e tmux attach -t $SESSION_NAME"
}

# Detect connected monitors
PRIMARY_MONITOR=$(xrandr --query | grep " connected primary" | cut -d ' ' -f1)
SECONDARY_MONITOR=$(xrandr --query | grep " connected" | grep -v "primary" | cut -d ' ' -f1)

# Default to primary monitor if no secondary monitor is found
if [ -z "$SECONDARY_MONITOR" ]; then
  SECONDARY_MONITOR=$PRIMARY_MONITOR
fi

# Create scratchpad session
SCRATCHPAD_SESSION="scratchpad"
tmux has-session -t $SCRATCHPAD_SESSION 2>/dev/null

if [ $? != 0 ]; then
  tmux new-session -d -s $SCRATCHPAD_SESSION -n "home"
fi

# Create scratchpad i3 workspace on primary monitor
create_i3_workspace 1 $SCRATCHPAD_SESSION $PRIMARY_MONITOR

# Check for arguments and create respective sessions
if [ $# -eq 0 ]; then
  # No arguments, only launch scratchpad session in i3
  i3-msg -s "$I3SOCK" "workspace 1"
else
  # Workspace counter starting from 2 (since 1 is for scratchpad)
  WORKSPACE_NUM=2

  # Iterate over arguments to create specified sessions
  for SESSION_NAME in "$@"; do
    case $SESSION_NAME in
    dino_infra)
      create_session "dino_infra" "main_window1" "~/work/DINO/infra-tbd" "nvim ." "ssh -i ssh/id_rsa dino@192.168.3.32" "ssh -i ssh/id_rsa dino@192.168.3.36"
      create_i3_workspace $WORKSPACE_NUM "work_session1" $SECONDARY_MONITOR
      ;;
    session2)
      create_session "work_session2" "main_window2" "~/work/p138/" "cd ~/another/dir" "cd ~/yet/another/dir"
      create_i3_workspace $WORKSPACE_NUM "work_session2" $SECONDARY_MONITOR
      ;;
    # Add more cases here for additional sessions
    *)
      echo "Unknown session name: $SESSION_NAME"
      ;;
    esac
    WORKSPACE_NUM=$((WORKSPACE_NUM + 1))
  done

  # Focus on the first specified workspace or scratchpad if none found
  if [ -n "$1" ]; then
    i3-msg -s "$I3SOCK" "workspace 2"
  else
    i3-msg -s "$I3SOCK" "workspace 1"
  fi
fi
