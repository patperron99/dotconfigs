# Autostart applications
/usr/bin/lxpolkit &

# bar start
~/.config/i3/polybar-i3 &

# wallpaper
# feh --bg-fill /usr/share/wallpapers/default &
feh --bg-fill ~/.config/backgrounds/bison.jpg

# compositor and notifications
picom -b &
numlockx on &
dunst &
blueman-applet &
nm-applet &
if ! pgrep -x "flameshot" > /dev/null; then flameshot & fi

# Configure monitors
exec ~/.config/i3/monitor_setup.sh
