#!/bin/bash
# Sequential app launcher for Hyprland
# Launches each app and waits for its window to appear before launching the next

# Launch HEY in workspace 1
hyprctl dispatch workspace 1
uwsm app -- omarchy-launch-webapp https://app.hey.com &
sleep 1

# Launch Basecamp in workspace 2
hyprctl dispatch workspace 2
uwsm app -- omarchy-launch-webapp https://launchpad.37signals.com &
sleep 1

# Launch Chromium in workspace 3
hyprctl dispatch workspace 3
uwsm app -- /usr/bin/chromium &
sleep 1

# Launch Terminal in workspace 4
hyprctl dispatch workspace 4
uwsm app -- $TERMINAL &
sleep 1

# Launch Telegram in workspace 5
hyprctl dispatch workspace 5
uwsm app -- Telegram &
sleep 1

# Return to workspace 4
hyprctl dispatch workspace 4
