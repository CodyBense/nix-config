#!/usr/bin/env bash

# waybar &
qs -c noctalia-shell &
nm-applet --indicator &
swaync &
udiskie &
sleep 1
emacsclient -c &
sleep 1
niri-monitor-toggle.sh
