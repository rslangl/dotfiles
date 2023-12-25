# Autostart X at login
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  exec startx
fi

# Set background picture
feh --no-fehbg --bg-scale ~/Pictures/Wallpapers/astartes.jpeg
