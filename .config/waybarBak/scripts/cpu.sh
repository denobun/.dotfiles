#!/bin/bash

STATE_FILE="/tmp/cpu_display_state"

if [ ! -f "$STATE_FILE" ]; then
    echo 0 > "$STATE_FILE"
fi

STATE=$(cat "$STATE_FILE")

if [ "$1" == "click" ]; then
    if [ "$STATE" == "0" ]; then
        echo 1 > "$STATE_FILE"
    else
        echo 0 > "$STATE_FILE"
    fi
    exit 0
fi

if [ "$STATE" == "0" ]; then
    CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print 100-$8"%"}')
    echo "$CPU"
else
    TEMP=$(cat /sys/class/thermal/thermal_zone0/temp)
    TEMP=$((TEMP / 1000))
    echo "$TEMP°C"
fi
