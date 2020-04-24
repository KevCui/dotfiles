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
export PATH="$PATH":${HOME}/Script:${HOME}/.cabal/bin:${HOME}/.npm-global/bin:${HOME}/.local/bin:${HOME}/go/bin:${HOME}/.cargo/bin
export TERM='xterm-256color'
export BROWSER="firefox"
export EDITOR="nvim"
export sys=/etc/systemd/system
export libsys=/usr/lib/systemd/system
export pkg=/var/cache/pacman/pkg
GPG_TTY=$(tty)
export GPG_TTY
export GITREPO="${HOME}/git"
export SNIPPET="${HOME}/Notes/command-snippet.md"
export WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"

# Android SDK
export ANDROID_SDK=/opt/android-sdk
export ANDROID_SDK_ROOT="$ANDROID_SDK"
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
export FFF_TRASH="${HOME}/.local/share/Trash/fff"
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

#/ antonym <word>: search for antonym of a word
antonym() { curl -sS https://www.thesaurus.com/browse/$1| pup 'script text{}' | grep INITIAL_STATE | sed 's/.*INITIAL_STATE = //;s/;$//' | jq -r '.searchData.tunaApiData.posTabs[] | .definition as $definition | .pos as $pos | .antonyms | sort_by (.term) | .[] | select((.similarity | tonumber)<-51) | "\($pos) \($definition):: \(.term)"' | awk -F"::" '{if ($1==prev) printf ",%s", $2; else printf "\n\n%s\n %s", $1, $2; prev=$1} END {print "\n"}' }

#/ buildapk <keystore> <alias>: sign apk
buildapk () { cordova build --release; jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore "$1" android-release-unsigned.apk "$2";zipalign -v 4 android-release-unsigned.apk android-signed.apk;zipalign -c -v 4 android-signed.apk }

#/ calibreadd: add book to calibre db
calibreadd () { calibredb add "$1" -T new }

#/ calibreconvert: convert book to azw3 format
calibreconvert () { file="$1"; ebook-convert "$file" "${file%.*}.azw3" --from-opf=metadata.opf --cover=cover.jpg --output-profile=kindle }

#/ cht <language> <question>: cheat sheet
cht () { curl "cht.sh/$1/$2" }

#/ clock: show running clock
clock () { clear; while true; do echo -e \\b\\b\\b\\b\\b\\b\\b\\b`date +%T`\\c ; sleep 1; done }

#/ citytime <city_name>: show current time in city $1
citytime () { zdump "$(fd -t f -d 2 "$1" /usr/share/zoneinfo/ | tail -1)" }

#/ cpu <keyword>: find CPU info from PassMark: Name; Mark; Rank; Value; Price
cpu () { curl -sS 'https://www.cpubenchmark.net/cpu_list.php' | grep 'cpu_lookup' | sed -e 's/<\/td><\/tr>/\n/g' -e 's/<tr.*multi=\w">//g' -e 's/<\/a><\/td><td>/; /g' -e 's/<\/td><td>/; /g' -e 's/<tr//g' -e 's/><td>//g' | awk -F '>' '{print $2}' | sed -e 's/<a href=.*//g' | grep -i "$1"}

#/ currency <from_currency> <to_currency> <number>: fetch currency exchange rate
currency () { $GITREPO/xe-cli/xe.sh "$1" "$2" "$3" }

#/ dadjoke: show dadjoke
dadjoke () { echo $(curl -sS -H "Accept: text/plain" https://icanhazdadjoke.com/)'\n' }

#/ dispabove: put sencond display above
#/ dispoff: HDMI display screen off
#/ dispon: HDMI display screen on
dispabove () { xrandr --output HDMI-1 --mode 1920x1080 --above eDP-1 }
dispoff () { xrandr --output HDMI-1 --off }
dispon () { xrandr --output HDMI-1 --mode 1920x1080 --same-as eDP-1 }

#/ douban <movie_name>: douban movie search
douban () { $GITREPO/pUtility/pUtility.js "https://search.douban.com/movie/subject_search?search_text=$1" -c html -w 100 | pup '.sc-bZQynM' --charset utf-8 | sed -E '/<\/div>/d;/<span/d;/<\/span>/d;/<a/d;/<\/a>/d;/<img/d' | sed -E '/<div class="meta abstract/{n;d}' | sed -E '/class="meta/d;/class="item-root"/d;/class="title"/d;/class="detail"/d;/class="rating/d' | sed -E 's/^\s+//' | awk '{if ($0 ~ /sc-bxivhb/) printf "\n"; else printf " - %s", $0}'
}

#/ emptytrash: remove files in local trash folder
emptytrash() { rm -rf "$HOME/.local/share/Trash"}

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
  else
      echo "'$1' is not a valid file"
  fi
}

#/ findlast: find last modified file in folder
findlast () { p="$1"; if [[ -z "$1" ]]; then p="."; fi; find "$p" -type d -exec sh -c "echo {}; /bin/ls -lrtp {} 2> /dev/null | grep -v / | tail -n 1 | awk '{\$1=\$2=\$3=\$4=\$5=\"\"; print \$0}'; echo" \; }

#/ geocode <address>: gecode an address
geocode () { curl -sS "https://www.qwant.com/maps/geocoder/autocomplete?q=${1// /%20}" | jq -r '.features[0].geometry.coordinates | "\(.[1] | tostring | split(".") | .[0]).\(.[1] | tostring | split(".") | .[1][0:6]),\(.[0] | tostring | split(".") | .[0]).\(.[0] | tostring | split(".") | .[1][0:6])"'}

#/ goodreads <book>: goodreads search
goodreads () {}

#/ help <keyword>: list functions
help () { grep "^#/" ~/.zshrc | cut -c4- | rg -i "${@:-}" }

#/ holiday <country_code> <year>: list of public holidays in country $1 in year $2
holiday () { [[ -z $2 ]] && y=$(date "+%Y") || y="$2"; curl -s "https://date.nager.at/Api/v2/PublicHolidays/$y/$1" | jq -r '.[] | "\(.date) \(.localName) - \(.name)"' }

#/ holidayHH: list of next public holidays of this year in Hamburg
holidayHH () { curl -s "https://date.nager.at/Api/v2/PublicHolidays/$(date "+%Y")/DE" | jq -r '.[] | select(((.counties | . and contains(["DE-HH"])) or .global) and .date >= "'$(date "+%Y-%m-%d")'") | "\(.date) \(.localName) - \(.name)"' }

#/ httpstatus: show HTTP code explanation, $1 HTTP code
httpstatus () { curl -i "https://httpstat.us/$1" }

#/ httpstatuslist: show list of HTTP codes
httpstatuslist () { curl -s 'https://httpstat.us/' | pup -p 'dl text{}' | sed -E '/^[[:space:]]*$/d' | awk 'NR%2{printf "%s ",$0;next}{print}' }

#/ imdb <title>: imdb search
imdb () {
    while read -r i; do
        if [[ "$i" == "tt"* ]]; then
            s=$(curl -sS "https://www.imdb.com/title/$i/")
            t=$(pup 'h1 text{}' --charset utf-8 <<< "$s" | sed -E '/^[[:space:]]*$/d;s/^[[:space:]]+//;s/[[:space:]]+$//' | awk '{printf $0}')
            st=$(pup '.subtext text{}' --charset utf-8 <<< "$s" | sed -E '/^[[:space:]]*$/d;s/^[[:space:]]+//' | awk '{printf $0}')
            r=$(pup '.ratingValue text{}' <<< "$s" | sed -E '/^[[:space:]]*$/d' | head -1)
            rc=$(pup 'span[itemprop="ratingCount"] text{}' <<< "$s")
            if [[ "$r" == "" ]]; then
                printf "%b\n" '\033[32m'"$t"'\033[0m - '"$st"
            else
                printf "%b\n" '\033[33m['"$r"' ('"$rc"')]\033[0m \033[32m'"$t"'\033[0m - '"$st"
            fi
        fi
    done <<< $(curl -sS "https://v2.sg.media-imdb.com/suggestion/${1:0:1}/$1.json" | jq -r '.d[].id')
}

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

#/ myanimelist <anime_name>: search anime info
myanimelist () { curl -sS "https://myanimelist.net/search/prefix.json?type=all&keyword=$1&v=1" | jq -r '.categories[] | select (.type == "anime") | .items[] | "[\(.payload.score)]+\(.name)++\(.payload.media_type)+\(.payload.aired)"' | column -t -s '+' }

#/ myip: show my ip address
myip () { curl -4 'icanhazip.com'; curl -6 'icanhazip.com' }

#/ mytimezone: show my timezone
mytimezone () { curl -s 'https://ipapi.co/timezone' }

#/ mytraceroute: returns a traceroute from my servers to my ip address
mytraceroute () { curl 'icanhaztraceroute.com' }

#/ mytrafficproxied : determine if my taffic is proxied or not
mytrafficproxied () { curl 'icanhazproxy.com' }

#/ po <second>: poweroff in seconds
po () { sleep "$1" && systemctl poweroff; }

#/ qotd: quote of the day
qotd () { curl -s 'https://favqs.com/api/qotd' | jq -r '.quote | "\"\(.body)\" - \(.author)"'; echo }

#/ randompwd <length>: generate random password
randompwd() { </dev/urandom | tr -dc 'a-zA-Z0-9!@#$%^&*()[]{}_=+-?.,:;' | head -c$1; echo"" }

#/ reversegeocode <lat,log>: reverse geocoding
reversegeocode () {
    curl -sS "http://www.mapquestapi.com/geocoding/v1/reverse?key=${MAP_QUEST_KEY}&location=${1// /%20}" | jq -r '.results[0].locations[0] | "\(.street), \(.postalCode) \(.adminArea5)"'
}

#/ rawtojpg <raw_file>: convert raw image to jpg
rawtojpg () { mkdir -p jpg; for i in *.CR2; do dcraw -c "$i" | cjpeg -quality 100 -optimize -progressive > ./jpg/$(echo $(basename "$i" ".CR2").jpg); done }

#/ rotd: show riddles of the day, with answers :)
rotd () { curl -s 'https://www.riddles.com/riddle-of-the-day'| pup -p '.panel-body p text{}' | awk 'NR%2 {print} !(NR%2) {printf "\033[02;30m%s\033[0m\n\n",$0}' }

#/ screenshot: take screenshot
screenshot () { sleep 2; import -window root `date +%s`.jpg }

#/ showpath: show PATH
showpath () { awk -v RS=: '{print}' <<<$PATH }

#/ synonym <word>: search for synonym of a word
synonym() { curl -sS https://www.thesaurus.com/browse/$1| pup 'script text{}' | grep INITIAL_STATE | sed 's/.*INITIAL_STATE = //;s/;$//' | jq -r '.searchData.tunaApiData.posTabs[] | .definition as $definition | .pos as $pos | .synonyms | sort_by (.term) | .[] | select((.similarity | tonumber)>49) | "\($pos) \($definition):: \(.term)"' | awk -F"::" '{if ($1==prev) printf ",%s", $2; else printf "\n\n%s\n %s", $1, $2; prev=$1} END {print "\n"}' }

#/ v <img> [viu params]: display image in terminal
v () { [[ "$(echo $1 | tr '[a-z]' '[A-Z]')" =~ (CR2|DNG)$ ]] && dcraw -c -w "$1" | cjpeg | viu "${@:2}" || viu "$@" }

#/ weather <location>: get weather info
weather () { curl "wttr.in/$1" }

#/ weatherhourly <location>: get hourly weather info
weatherhourly () {
    coordinate=$(curl -sS "https://www.qwant.com/maps/geocoder/autocomplete?q=${1// /%20}" | jq -r '.features[0].geometry.coordinates | "\(.[1]),\(.[0])"')

    printf "%b: %b\n" "\e[33m$1" "$coordinate\e[0m"

    result=$(curl -sS "https://api.darksky.net/forecast/${DARK_SKY_KEY}/$coordinate,$(date +%s)?exclude=daily,minutely,flags&units=si")
    printf "\n\e[33mCURRENTLY\e[0m\n"
    echo "$result" | jq -r '.currently | "\(.time | localtime | strftime("%m-%d %H:%M"))+\(.temperature|round)°C+\(.summary)+\(.precipProbability*100|round)%"' | column -t -s'+'
    printf "\n\e[33mTODAY HOURLY\e[0m\n"
    echo "$result" | jq -r '.hourly.data | .[] | "\(.time | localtime | strftime("%m-%d %HH"))+\(.temperature|round)°C+\(.summary)+\(.precipProbability*100|round)%"' | column -t -s'+'

    printf "\n\e[33mTOMORROW HOURLY\e[0m\n"
    curl -sS "https://api.darksky.net/forecast/${DARK_SKY_KEY}/$coordinate,$(date --date='next day' +%s)?exclude=daily,minutely,flags&units=si" | jq -r '.hourly.data | .[] | "\(.time | localtime | strftime("%m-%d %HH"))+\(.temperature|round)°C+\(.summary)+\(.precipProbability*100|round)%"' | column -t -s'+'
}

#/ whatcms: show cms used by website $1
whatcms () { curl -sS "https://whatcms.org/APIEndpoint/Detect?key=$(cat $WHATCMS_KEY_FILE | shuf | tail -1)&url=$1" | jq . }

#/ whohosts: show host info of website $1
whohosts () { curl -sS "https://www.who-hosts-this.com/APIEndpoint/Detect?key=$(cat $WHATCMS_KEY_FILE | shuf | tail -1)&url=$1" | jq . }

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
alias rg='rg -i'
alias ccat='pygmentize -g -O style=colorful,linenos=1'
alias vi='nvim'
alias vif='$EDITOR $(fzf --preview="cat {}" --preview-window=right:70%:wrap)'
alias cdf='cd "$(find * -type d | fzf --preview="ls {}" --preview-window=right:70%:wrap)"'
alias nv='$EDITOR -c NV'
alias ls='exa -s mod --git'
alias lsg='exa -s mod --git | rg "$@"'
alias ll='exa -l -s mod --git --time-style=long-iso'
alias llg='exa -l -s mod --git --time-style=long-iso | rg "$@"'
alias s='export lst=$(ls | tail -1); export fst=$(ls | head -1)'
alias y='yay'
alias unplug='devmon -u'
alias diff='colordiff'
alias ping='prettyping --nolegend'
alias top='htop'
alias cat='bat --theme=iceberg'
alias aik='aiksaurus'
alias c='insect'
alias ts='torsocks'
alias u='/usr/bin/up'
alias please='sudo $(fc -ln -1)'
alias copy='xclip -selection clipboard'

# git alias
alias cdg="cd $GITREPO"
alias cdb="cd $GITREPO/blog"
alias gitundo='git reset -- $1'
alias g='git'
alias gita='python3 -m gita'
alias gitall='gita ls'

# hugo alias
alias hugos="cd $GITREPO/blog; hugo server -D >/dev/null &"

# python server
alias python-server='ip addr | grep "state UP" -A 2 | grep -Eo "inet [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"; python3 -m http.server 8000'

# run firefox or chromium in new instance
alias newfox='firefox --profile $(mktemp -d)'
alias newchromium='chromium --user-data-dir=$(mktemp -d)'
alias newchromiumwithproxy='http_proxy="localhost:8080" https_proxy="localhost:8080" chromium --user-data-dir=$(mktemp -d)'
alias newchromiumwithtor='chromium --user-data-dir=$(mktemp -d) --proxy-server="socks5://127.0.0.1:9050" --host-resolver-rules="MAP * 0.0.0.0 , EXCLUDE localhost"'

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
# Completion
#------------------------------
autoload -Uz compinit
compinit
setopt completealiases
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
export FZF_TAB_OPTS=(
    --no-info
    --ansi
    --expect='$continuous_trigger'
    '--color=hl:$(( $#headers == 0 ? 108 : 255 ))'
    --nth=2,3 --delimiter='\x00'
    --layout=reverse --height='${FZF_TMUX_HEIGHT:=75%}'
    --tiebreak=begin -m --bind=tab:down,btab:up,ctrl-j:up,ctrl-k:down,change:top,alt-space:toggle,space:accept --cycle
    '--query=$query'
    '--header-lines=$#headers'
)

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
source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/.zsh/fzf-tab/fzf-tab.plugin.zsh

export HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
export HISTORY_SUBSTRING_SEARCH_FUZZY=1

#------------------------------
# Widgets
#------------------------------
fetch_history_commands() {
    # $1: nth command in history
    local n command command_array=() all_command_array=()
    n="$1"
    for (( i = 1; i < $((n+1)); i++ )); do
        command=$history[$[HISTCMD-$i]]
        command_array=("${(s/ /)command}")
        all_command_array=("${all_command_array[@]}" "${command_array[@]:1}")
    done

    printf '%s\n' "${all_command_array[@]}" | sort -u | sed -E '/^[[:space:]]*$/d'
}

fzf_in_widget() {
    fzf --no-info --ansi -0 -1 --reverse --height=40% --bind=ctrl-j:up,ctrl-k:down,space:accept,tab:down,btab:up
}

show_args_in_prev_command() {
    local sel
    sel=$(fetch_history_commands 1 | fzf_in_widget)
    zle redisplay
    [[ -n "$sel" ]] && LBUFFER="${LBUFFER}${sel} "
    return 0
}

show_args_in_prev_ten_commands() {
    sel=$(fetch_history_commands 10 | fzf_in_widget)
    zle redisplay
    [[ -n "$sel" ]] && LBUFFER="${LBUFFER}${sel} "
    return 0
}

zle -N show_args_in_prev_command
zle -N show_args_in_prev_ten_commands

#------------------------------
# Keybindings
#------------------------------
bindkey -v
export KEYTIMEOUT=10
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
bindkey "^[1" show_args_in_prev_command
bindkey "^[2" show_args_in_prev_ten_commands
bindkey -M vicmd 'j' history-substring-search-up
bindkey -M vicmd 'k' history-substring-search-down

#------------------------------
# SSH
#------------------------------
eval `ssh-agent -s` > /dev/null
ssh-add ${HOME}/.ssh/id_rsa &> /dev/null

#------------------------------
# Other source
#------------------------------
stty -ixon # disable ^S
source ~/.czshrc
