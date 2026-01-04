#!/usr/bin/env bash

TERMINAL="$1"

if [[ -n "$TERMINAL" ]]; then
    swaymsg "workspace 2"
    swaymsg "exec $TERMINAL"
    swaymsg "exec $TERMINAL"
    sleep 20
    swaymsg "layout toggle split"
    swaymsg "split v"
    swaymsg "exec $TERMINAL"
    sleep 1
    swaymsg 'resize grow height 70 px'
fi
