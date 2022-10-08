# Map CapsLock to Control
setxkbmap -option ctrl:nocaps

# Map short-pressed Control to Escape
xcape -e 'Control_L=Escape'

# Set faster key repeat and lower delay
# Delay: 200ms
# 45 keys per sec
xset r rate 200 45

# Start picom
picom -b

xrandr --output eDP --mode 3840x2160 --pos 4920x0 --rotate normal --output DisplayPort-0 --off --output DisplayPort-1 --primary --mode 3840x2160 --pos 1080x0 --rotate normal --output DisplayPort-2 --mode 1920x1080 --pos 0x120 --rotate right

