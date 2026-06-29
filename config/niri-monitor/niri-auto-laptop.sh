#!/bin/bash

prev_hdmi=1

while true; do
    sleep 2

    outputs=$(niri msg outputs 2>/dev/null) || continue
    hdmi=$(echo "$outputs" | grep -c "HDMI-A-1")
    laptop_off=$(echo "$outputs" | awk '/eDP-1\)$/ {found=1} found && /Disabled/ {print "yes"; exit}')

    if [ "$hdmi" -eq 0 ] && [ "$laptop_off" = "yes" ]; then
        niri msg output "eDP-1" on
    elif [ "$hdmi" -eq 1 ] && [ "$prev_hdmi" -eq 0 ] && [ "$laptop_off" != "yes" ]; then
        niri msg output "eDP-1" off
    fi

    prev_hdmi=$hdmi
done
