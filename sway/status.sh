#!/bin/env bash

i=1
while true; do
    i="$((i-1))"
    if [[ "$i" -eq 0 ]]; then
        CPU="CPU: $(top -b -n 1 | rg 'Cpu\(s\)' | sed 's/us,.*//' | awk -F: '{print $2}' | awk '{$1=$1};1')%"
        GPU="GPU: $(nvidia-smi -a | rg 'Current Temp' | awk -F ': ' '{print $2}' | awk '{print $1}' | head -1)°C"
        DATE="$(date +'%d %b   %a   %I:%M')"
        MEM="$(free -h | awk '/Mem:/ {printf("MEM: %5s\n", $3)}')"
        i=5
    fi

    if [[ "$(pamixer --get-mute)" == true ]]; then
        VOL="MUTE: $(pamixer --get-volume)%"
    else
        VOL="VOL: $(pamixer --get-volume)%"
    fi

    echo "<span foreground=\"#a3be8c\">$CPU</span>  |  <span foreground=\"#a3be8c\">$GPU</span>  |  <span foreground=\"#a3be8c\">$MEM</span>  |  <span foreground=\"#b48ead\">$VOL</span>  |  <span foreground=\"#d8dee9\">$DATE</span>"

    sleep 1
done
