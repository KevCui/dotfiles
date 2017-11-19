#------------------------------
# Prompt
#------------------------------
setprompt () {
  # load some modules
  autoload -U colors zsh/terminfo # Used in the colour alias below
  colors
  setopt prompt_subst

  PS1="%{$fg[red]%}●%{$fg[yellow]%}●%{$fg[green]%}● %{$fg[blue]%}\$(date +'%H:%M:%S') %{$fg[yellow]%}>>%{$fg[white]%} "
  RPROMPT="%{$fg[green]%}%/%b"
}
setprompt

#------------------------------
# Variables
#------------------------------
export PATH="$PATH":${HOME}/Script:/opt/android-sdk/tools/bin/:/opt/android-sdk/platform-tools/:${HOME}/bin:${HOME}/.cabal/bin
export TERM='rxvt-256color'
export BROWSER="firefox-nightly"
export EDITOR="vim"
export sys=/etc/systemd/system
export libsys=/usr/lib/systemd/system
export pkg=/var/cache/pacman/pkg

# Android SDK
export ANDROID_SDK=/opt/android-sdk/
export ANDROID_NDK=${HOME}/android-ndk-r9d
export NDK_ROOT=${HOME}/android-ndk-r9d
export JAVA_HOME=/usr/lib/jvm/default/
export PATH=$ANDROID_SDK:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools:$PATH

# awesome wm
#export rclua={$HOME|/.config/awesome/rc.lua
#export alog=${HOME}/.cache/awesome

#------------------------------
# Functions
#------------------------------
# all-in-one decompression
extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2) tar xjf $1 ;;
      *.tar.gz) tar xzf $1 ;;
      *.bz2) bunzip2 $1 ;;
      *.rar) unrar e $1 ;;
      *.gz) gunzip $1 ;;
      *.tar) tar xf $1 ;;
      *.tar.xz) tar xf $1 ;;
      *.tbz2) tar xjf $1 ;;
      *.tgz) tar xzf $1 ;;
      *.zip) unzip $1 ;;
      *.Z) uncompress $1 ;;
      *.7z) 7z x $1 ;;
      *) echo "'$1' cannot be extracted via extract()" ;;
    esac
    rm -rf $1
  else
      echo "'$1' is not a valid file"
  fi
}

# mkdir + cd
mcd() { mkdir -p "$1" && cd "$1"; }

# poweroff
po() { pactl set-sink-mute 0 1;sleep "$1" && sudo systemctl poweroff; }

# js compressor
yuijs() { echo "$1".js; rm -f $1.min.js; java -jar ${HOME}/Script/yuicompressor-2.4.8.jar --type js "$1".js > "$1".min.js;}
# css compressor
yuicss() { echo "$1".css; rm -f $1.min.css; java -jar ${HOME}/Script/yuicompressor-2.4.8.jar --type css "$1".css > "$1".min.css;}

# sign apk
buildapk() { cordova build --release; jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore "$1" android-release-unsigned.apk "$2";zipalign -v 4 android-release-unsigned.apk android-signed.apk;zipalign -c -v 4 android-signed.apk }

# take screenshot
screenshot () { sleep 2; import -window root `date +%s`.jpg }

# aria2c download
dl () { aria2c -c -s 5 "$1" --all-proxy="" }
dnl () { aria2c -c -s 5 "$1" }

# HDMI display screen on/off
dispon () { xrandr --output HDMI-1 --mode 1920x1080 --right-of eDP-1 }
dispoff () { xrandr --output HDMI-1 --off }

#------------------------------
# Alias
#------------------------------
# general alias
alias 'rm=rm -i'
alias 'ls=ls --color=auto'
alias 'dir=dir --color=auto'
alias 'vdir=vdir --color=auto'
alias 'grep=grep --color=auto'
alias 'fgrep=fgrep --color=auto'
alias 'egrep=egrep --color=auto'
alias 'cdd=cd ~/Downloads'
alias 'cdp=cd $PATH_NOW'
alias 'pt=export PATH_NOW=`pwd`'
alias 'cds=cd ~/Script'
alias 'cdb=cd ~/Dropbox'
alias 'pg=ps aux | grep $1'
alias 'pk9=pkill -9 -f $1'
alias 'c=clear'
alias 'pg=ps aux | grep $@'
alias 'lg=ls -ltr | grep $@'
alias 'vi=vim'
alias 'ls=ls --color -F'
alias 'hl=ls -ltr --color -lh'
alias ll="ls -ltr --color -lh"
alias y='yaourt'
alias unplug='devmon -u'
alias weather='curl wttr.in/$1'

# ruby twitter cli alias
#alias tmen="t mention -r"
#alias tre="t retweet"
#alias tu="t update $1"
#alias tdel="t delete status $1"
#alias ts="t stream timeline"

# git alias
alias cdg="cd ~/git"
alias cdgb="cd ~/git/blog"
alias gitundo="git reset -- $1"
alias g="git $@"

# hexo alias
# alias hd="hexo g;hexo d"
# alias hb="hexo backup;git push"

# hugo alias
alias hugos="cd ~/git/blog; hugo server -t=uno -D"

#------------------------------
# History
#------------------------------
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000
function h() {
  if [ -z "$*" ]; then
    history 1;
  else
    history 1 | egrep "$@";
  fi
}

# share history
setopt share_history
setopt inc_append_history

#-----------------------------
# Dircolors
#-----------------------------
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

#------------------------------
# Keybindings
#------------------------------
bindkey '^B' beginning-of-line
bindkey '^E' end-of-line
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey "^R" history-incremental-search-backward

#------------------------------
# Comp
#------------------------------
autoload -U colors && colors
autoload -U compinit promptinit
zstyle ':completion:*' menu select
setopt completealiases
zmodload zsh/complist
autoload -Uz compinit
compinit
zstyle :compinstall filename '${HOME}/.zshrc'

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*'   force-list always

#------------------------------
# SSH
#------------------------------
eval `ssh-agent -s` > /dev/null
ssh-add ${HOME}/.ssh/githubkey &> /dev/null
ssh-add ${HOME}/.ssh/secretkey &> /dev/null
ssh-add ${HOME}/.ssh/id_rsa &> /dev/null
