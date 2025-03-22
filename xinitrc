#!/usr/bin/zsh

# Apply settings for xterm
xrdb -merge ~/.Xresources

# Prevent monitor sleep
xset s off
xset -dpms

# Touchpad
synclient TapButton2=3 TapButton1=1 AccelFactor=0.09 MaxSpeed=5 PalmDetect=1 PalmMinWidth=8 PalmMinZ=100 VertScrollDelta=-73
## disable touchpad when typing
syndaemon -i 0.8 -t -K -R -d

# Mouse
imwheel --kill
xbindkeys

# Keyboard layout
xmodmap $HOME/.Xmodmap

# Workaround to avoid slow startup when launching nvim for the first time
nohup nvim -c quit > /dev/null 2>&1 &

# Start i3
exec i3
