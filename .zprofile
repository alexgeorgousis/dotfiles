# Launches sway at startup.
# The logic reads: If you're not already in a graphical session, and you're on the first TTY, then launch sway.
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
  exec WLR_RENDERER_ALLOW_SOFTWARE=1 sway --unsupported-gpu
fi
