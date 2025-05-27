# Autostart applications
if ! pgrep -x lxpolkit > /dev/null; then
    /usr/bin/lxpolkit &
fi
 
# wallpaper
swaybg -i ~/.config/backgrounds/default

numlockx on &

