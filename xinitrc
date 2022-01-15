#!/usr/bin/zsh

# monitor calibration
$HOME/.monicarc

# fcitx setup
export XMODIFIERS="@im=fcitx5"
export QT_IM_MODULE=fcitx5
export GTK_IM_MODULE=fcitx5

# Apply settings for xterm
xrdb -merge ~/.Xresources

# Touchpad
synclient TapButton2=3 TapButton1=1 AccelFactor=0.09 MaxSpeed=5 PalmDetect=1 PalmMinWidth=8 PalmMinZ=100 VertScrollDelta=-73
## disable touchpad when typing
syndaemon -i 0.8 -t -K -R -d

# Keyboard layout
xmodmap $HOME/.Xmodmap

# Start i3
exec i3
