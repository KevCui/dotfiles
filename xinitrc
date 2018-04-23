#!/usr/bin/zsh
# fcitx setup
export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx
export GTK_IM_MODULE=fcitx
export LC_CTYPE="zh_CN.UTF-8"

# Start network
sudo netctl start home &

# Apply settings for xterm
xrdb -merge ~/.Xresources

# Touchpad
synclient TapButton2=3 TapButton1=1 AccelFactor=0.09 MaxSpeed=5 PalmDetect=1 VertScrollDelta=-73
## disable touchpad when typing
syndaemon -i 0.5 -t -K -R -d

# Mute
#pamixer -m

# Start i3
exec i3
