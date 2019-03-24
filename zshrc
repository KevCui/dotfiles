#------------------------------
# Prompt
#------------------------------
autoload -U promptinit; promptinit
prompt spaceship
SPACESHIP_PROMPT_ORDER=(time char)
SPACESHIP_RPROMPT_ORDER=(git dir)
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_TIME_SHOW=true
SPACESHIP_TIME_COLOR="blue"
SPACESHIP_DIR_TRUNC=0
SPACESHIP_DIR_TRUNC_REPO=false
SPACESHIP_DIR_COLOR="green"
SPACESHIP_DIR_PREFIX=""
SPACESHIP_GIT_BRANCH_COLOR="yellow"
spaceship_vi_mode_enable

#------------------------------
# Variables
#------------------------------
export PATH="$PATH":${HOME}/Script:${HOME}/.cabal/bin:${HOME}/.npm-global/bin:${HOME}/.local/bin
export TERM='xterm-256color'
export BROWSER="firefox-nightly"
export EDITOR="nvim"
export sys=/etc/systemd/system
export libsys=/usr/lib/systemd/system
export pkg=/var/cache/pacman/pkg
GPG_TTY=$(tty)
export GPG_TTY
export GITREPO="%gitrepo%"
export SNIPPET="${HOME}/Notes/command-snippet.md"

# Android SDK
export ANDROID_SDK=/opt/android-sdk
export ANDROID_NDK=${HOME}/android-ndk-r9d
export NDK_ROOT=${HOME}/android-ndk-r9d
export JAVA_HOME=/usr/lib/jvm/default/
export PATH=$ANDROID_SDK:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools:$PATH

# fzf key bindings and color
export FZF_DEFAULT_OPTS='
  --bind ctrl-j:up,ctrl-k:down
  --color fg:250,hl:221,fg+:232,bg+:111,hl+:221
  --color info:111,prompt:221,spinner:221,pointer:111,marker:221
'
# fzf ignores .git and node_modules
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_S_COMMAND="cat $SNIPPET"

# fff configurations
export FFF_OPENER="rifle"
export FFF_COL2="01;38;5;111"
export FFF_KEY_SCROLL_DOWN1="k"
export FFF_KEY_SCROLL_UP1="j"
export FFF_FAV1="$GITREPO/fff/fav1"
export FFF_FAV2="$GITREPO/fff/fav2"
export FFF_FAV3="$GITREPO/fff/fav3"
export FFF_FAV4="$GITREPO/fff/fav4"
export FFF_FAV5="$GITREPO/fff/fav5"
export FFF_FAV6="$GITREPO/fff/fav6"
export FFF_FAV7="$GITREPO/fff/fav7"
export FFF_FAV8="$GITREPO/fff/fav8"
export FFF_FAV9="$GITREPO/fff/fav9"

#------------------------------
# Functions
#------------------------------
#/ = <expr>: calculator +-x/
= () {
    calc="${*//p/+}"
    calc="${calc//x/*}"
    calc $calc
}

#/ addpet: add command snippet to $SNIPPET
addpet () {
    read "?Command: " cmdinput
    read "?Description: " desinput
    echo "[$desinput]: $cmdinput" >> $SNIPPET
}

#/ alpha: print alphabet
alpha () {
    for x in {a..z}; do
        echo "$(($(printf "%d" "'$x")-96))\t$x"
    done
}

#/ buildapk <keystore> <alias>: sign apk
buildapk () { cordova build --release; jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore "$1" android-release-unsigned.apk "$2";zipalign -v 4 android-release-unsigned.apk android-signed.apk;zipalign -c -v 4 android-signed.apk }

#/ cht <language> <question>: cheat sheet
cht () { curl "cht.sh/$1/$2"}

#/ clock: show running clock
clock () { clear; while true; do echo -e \\b\\b\\b\\b\\b\\b\\b\\b`date +%T`\\c ; sleep 1; done }

# cpu <keyword>: find CPU info from PassMark: Name; Mark; Rank; Value; Price
cpu () { curl -sS 'https://www.cpubenchmark.net/cpu_list.php' | rg 'cpu_lookup' | sed -e 's/<\/TD><\/TR>/\n/g' -e 's/<TR.*multi=\w">//g' -e 's/<\/A><\/TD><TD>/; /g' -e 's/<\/TD><TD>/; /g' -e 's/<a href.*<\/a>//g' -e 's/<TR.*;id=.*\">//g' | rg -i "$1"}

#/ currency <from_currency> <to_currency> <number>: fetch currency exchange rate from XE
currency () { node "$GITREPO"/xe-scraper/xe-scraper.js $1 $2 $3}

#/ dadjoke: show dadjoke
dadjoke () { echo $(curl -Ss -H "Accept: text/plain" https://icanhazdadjoke.com/)'\n' }

#/ dispabove: put sencond display above
#/ dispoff: HDMI display screen off
#/ dispon: HDMI display screen on
dispabove () { xrandr --output HDMI-1 --mode 1920x1080 --above eDP-1 }
dispoff () { xrandr --output HDMI-1 --off }
dispon () { xrandr --output HDMI-1 --mode 1920x1080 --same-as eDP-1 }

#/ extract <file_name>: all-in-one decompression
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

#/ findlast: find last modified file in folder
findlast () { p="$1"; if [[ -z "$1" ]]; then p="."; fi; find "$p" -type d -exec sh -c "echo {}; /bin/ls -lrtp {} 2> /dev/null | grep -v / | tail -n 1 | awk '{\$1=\$2=\$3=\$4=\$5=\"\"; print \$0}'; echo" \; }

#/ help <keyword>: list functions
help () { grep "^#/" ~/.zshrc | cut -c4- | rg -i "${@:-}" }

#/ kp: kill process
kp () { kill $(ps aux | fzf | awk '{print $2}') }

#/ lm: show last modified time of sites, defined in ~/.site
lm () {
    for url in $(cat ~/.site); do
        echo "> $url"
        time=$(curl -Is "$url" | grep last | cut -c16-)
        echo "\t"$(date -d $time)
    done
}

#/ mcd <dir_name>: mkdir + cd
mcd () { mkdir -p "$1" && cd "$1"; }

#/ po <second>: poweroff in seconds
po () { sleep "$1" && systemctl poweroff; }

#/ rawtojpg <raw_file>: convert raw image to jpg
rawtojpg () { mkdir -p jpg; for i in *.CR2; do dcraw -c "$i" | cjpeg -quality 100 -optimize -progressive > ./jpg/$(echo $(basename "$i" ".CR2").jpg); done }

#/ screenshot: take screenshot
screenshot () { sleep 2; import -window root `date +%s`.jpg }

#/ showpath: show PATH
showpath () { awk -v RS=: '{print}' <<<$PATH }

#/ weather <location>: get weather info
weather () { curl "wttr.in/$1" }

#/ youtuberss <url>: get YouTube RSS QR code
youtuberss () { url=`curl -s "$1" | grep RSS | sed -e 's/.*href=\"//' | sed -e 's/\">.*//' | head -1`; echo $url; qr "$url"}

#/ yuicss <css_file>: css compressor
yuicss () { echo "$1".css; rm -f $1.min.css; java -jar ${HOME}/Script/yuicompressor-2.4.8.jar --type css "$1".css > "$1".min.css;}
#/ yuijs <js_file>: js compressor
yuijs () { echo "$1".js; rm -f $1.min.js; java -jar ${HOME}/Script/yuicompressor-2.4.8.jar --type js "$1".js > "$1".min.js;}

#/ zipundo <zip_file>: clean unzip mess
zipundo () { unzip -Z -1 "$1" | xargs -I{} rm -v {} }

#------------------------------
# Alias
#------------------------------
# general alias
alias rm='rm -i'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias ccat='pygmentize -g -O style=colorful,linenos=1'
alias vi='nvim'
alias vif='$EDITOR $(fzf --preview="cat {}" --preview-window=right:70%:wrap)'
alias nv='$EDITOR -c NV'
alias ls='exa -s mod --git'
alias lsg='exa -s mod --git | rg -i "$@"'
alias ll='exa -l -s mod --git --time-style=long-iso'
alias llg='exa -l -s mod --git --time-style=long-iso | rg "$@"'
alias y='yay'
alias unplug='devmon -u'
alias diff='colordiff'
alias ping='prettyping --nolegend'
alias top='htop'
alias cat='bat --theme=iceberg'
alias aik='aiksaurus'
alias c='insect'

# git alias
alias cdg="cd $GITREPO"
alias cdb="cd $GITREPO/blog"
alias gitundo='git reset -- $1'
alias g='git'
alias gita='python3 -m gita'
alias gitall='gita ls'

# hugo alias
alias hugos="cd $GITREPO/blog; hugo server -D"

# python server
alias python-server='ip addr | grep "state UP" -A 2 | grep -Eo "inet [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"; python3 -m http.server 8000'

# run firefox with default GTK3 theme
alias firefox='env GTK_THEME=Arc firefox-nightly'

# run firefox in new instance
alias newfox='firefox --new-instance --profile $(mktemp -d)'

# grc alias
if [[ "$TERM" != dumb ]] && (( $+commands[grc] )) ; then

  # Supported commands
  cmds=(
    cc \
    configure \
    cvs \
    df \
    dig \
    gcc \
    gmake \
    ifconfig \
    ip \
    last \
    ldap \
    make \
    mount \
    mtr \
    netstat \
    ping6 \
    ps \
    traceroute \
    traceroute6 \
    wdiff \
    whois \
    iwconfig \
  );

  # Set alias for available commands.
  for cmd in $cmds ; do
    if (( $+commands[$cmd] )) ; then
      alias $cmd="grc --colour=auto $(whence $cmd)"
    fi
  done

  # Clean up variables
  unset cmds cmd
fi

#------------------------------
# History
#------------------------------
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
h() { [ -z "$*" ] && history -i 1 || history -i 1 | egrep "$@" }

# share history
setopt share_history
setopt inc_append_history

#-----------------------------
# Dircolors
#-----------------------------
eval `dircolors ${HOME}/.dir_colors`

#------------------------------
# ZSH Plugins
#------------------------------
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/fzf/completion.zsh
source ~/.zsh/fzf/key-bindings.zsh
source ~/.zsh/fzf/command-snippet.zsh
source ~/.zsh/up.sh
source ~/.zsh/z.lua.plugin.zsh

export HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
export HISTORY_SUBSTRING_SEARCH_FUZZY=1

#------------------------------
# Keybindings
#------------------------------
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey '^[[P' delete-char
bindkey "^A" beginning-of-line
bindkey "^B" backward-char
bindkey '^E' end-of-line
bindkey "^F" forward-char
bindkey "^H" backward-delete-char
bindkey "^K" kill-line
bindkey "^L" clear-screen
bindkey "^N" down-history
bindkey "^P" up-history
bindkey "^U" kill-whole-line
bindkey "^W" backward-kill-word
bindkey "^Y" yank
%comment%bindkey -M vicmd 'j' history-substring-search-up
%comment%bindkey -M vicmd 'k' history-substring-search-down

#------------------------------
# Completion
#------------------------------
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
setopt completealiases

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

#------------------------------
# SSH
#------------------------------
eval `ssh-agent -s` > /dev/null
ssh-add ${HOME}/.ssh/id_rsa &> /dev/null

#------------------------------
# Other source
#------------------------------
stty -ixon # disable ^S
source %othersource%
