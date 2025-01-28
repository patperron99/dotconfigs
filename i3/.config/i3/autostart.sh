# sxhkd
sxhkd -c ~/.config/i3/sxhkdrc &

# Autostart applications
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

# bar start
~/.config/i3/polybar-i3 &

# wallpaper
feh --bg-fill /usr/share/wallpapers/default &

# compositor and notifications
picom -b &
numlockx on &
dunst &
blueman-applet &
nm-applet &
flameshot &

# Configure monitors
exec ~/.config/i3/monitor_setup.sh
