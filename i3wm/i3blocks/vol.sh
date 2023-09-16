#!/usr/bin/env bash
if [[ "$(pamixer --get-mute)" == true ]]; then
    echo "MUTE: $(pamixer --get-volume)%"
else
    echo "VOL: $(pamixer --get-volume)%"
fi
