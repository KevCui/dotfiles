#------------------------------
# Prompt
#------------------------------
setopt prompt_subst
PS1="%F{red}●%F{yellow}●%F{green}● %F{blue}%* %F{yellow}>>%f "
RPROMPT="%F{yellow}\$(git rev-parse --abbrev-ref HEAD 2> /dev/null) %F{green}%B%~%b"

#------------------------------
# Variables
#------------------------------
export PATH="$PATH":${HOME}/Script:/opt/android-sdk/tools/bin/:/opt/android-sdk/platform-tools/:${HOME}/bin:${HOME}/.cabal/bin
export TERM='xterm-256color'
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
      *.rar) unrar e $1 ;;
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
po() { sleep "$1" && sudo systemctl poweroff; }

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
dispon () { xrandr --output HDMI-1 --mode 1920x1080 --same-as eDP-1 }
dispabove () { xrandr --output HDMI-1 --mode 1920x1080 --above eDP-1 }
dispoff () { xrandr --output HDMI-1 --off }

# Print alphabet
alpha () {
    i=1
    for x in {a..z}; do
        echo "$i\t$x"
        i=$((i+1))
    done
}

# convert raw image to jpg
rawtojpg () { mkdir -p jpg; for i in *.CR2; do dcraw -c "$i" | cjpeg -quality 100 -optimize -progressive > ./jpg/$(echo $(basename "$i" ".CR2").jpg); done }

# get YouTube RSS QR code
youtuberss () { url=`curl -s "$1" | grep RSS | sed -e 's/.*href=\"//' | sed -e 's/\">.*//' | head -1`; echo $url; qr "$url"}

# fetch currency exchange rate
currency () { [ -z $3 ] && amount=1 || amount=$3; curl -s "https://www.xe.com/currencyconverter/convert/?Amount=$amount&From=$1&To=$2" | grep "uccResultUnit" | sed -e "s/.*uccFromResultAmount//" -e "s/resultRightArrow.*//" -e "s/<[^>]*>//g" -e "s/'>//" -e "s/&nbsp;//" -e "s/<span.*//"}

# get weather info
weather () { curl "wttr.in/$1" }

# calculator
= () {
    calc="${*//p/+}"
    calc="${calc//x/*}"
    calc $calc
}

#------------------------------
# Alias
#------------------------------
# general alias
alias rm='rm -i'
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias cdp='cd $PATH_NOW'
alias pt='export PATH_NOW=`pwd`'
alias cdd='cd ~/Downloads'
alias cds='cd ~/Script'
alias cdt='cd ~/.local/share/Trash'
alias pg='ps aux | grep $1'
alias pk9='pkill -9 -f $1'
alias c='clear'
alias pg='ps aux | grep $@'
alias lg='ls -ltr | grep $@'
alias vi='vim'
alias vif='vim $(fzf)'
alias ls='ls --color -F'
alias hl='ls -ltr --color -lh'
alias ll='ls -ltr --color -lh'
alias a='aurman'
alias unplug='devmon -u'

# git alias
alias cdg='cd ~/git'
alias cdb='cd ~/git/blog'
alias gitundo='git reset -- $1'
alias g='git $@'

# hugo alias
alias hugos='cd ~/git/blog; hugo server -t=uno -D'

# python server
alias python-server='python3 -m http.server 8000'

#------------------------------
# History
#------------------------------
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000
function h() { [ -z "$*" ] && history 1 || history 1 | egrep "$@" }

# share history
setopt share_history
setopt inc_append_history

#-----------------------------
# Dircolors
#-----------------------------
eval `dircolors ${HOME}/.dir_colors`

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
