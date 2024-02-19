#!/bin/env bash

# terminate already running bars
killall -q polybar

# wait until bars have been terminated
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# manage multiple monitors
for m in $(polybar --list-monitors | cut -d":" -f1); do
  MONITOR=$m polybar --reload top &
done
