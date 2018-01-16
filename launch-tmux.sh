#!/bin/zsh

# Main |-
tmux new-session -d -s main -n main
tmux split-window -h -p 40 'while true; do tput clear; date;echo;task ls; sleep 300; done'
tmux split-window -v 'task shell'

# File Manager
tmux new-window -n "file" 'source .zshrc; ranger'
tmux select-pane -t 0

# Script |
tmux new-window -n "other"
tmux split-window -h -p 50
tmux select-pane -t 0

tmux select-window -t main
tmux attach
