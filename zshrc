#------------------------------
# Prompt
#------------------------------
autoload -U promptinit; promptinit
prompt spaceship
SPACESHIP_PROMPT_ORDER=(user time char)
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
export GPG_TTY=$(tty)
export GITREPO="${HOME}/git"
export SNIPPET="${HOME}/Notes/command-snippet.md"
export WORDCHARS="*?_-.[]~=&;!#$%^(){}<>|"

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
  --color hl+:221,info:111,prompt:221,spinner:221,pointer:111,marker:221
'

# fzf ignores .git and node_modules
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null | deviconslookup.sh'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--bind "enter:abort+execute(echo {2})"'
export FZF_CTRL_S_COMMAND="cat $SNIPPET"

# fff configurations
export FFF_OPENER="rifle"
export FFF_COL2="01;38;5;111"
export FFF_KEY_SCROLL_DOWN1="k"
export FFF_KEY_SCROLL_UP1="j"
export FFF_TRASH="${HOME}/.local/share/Trash/fff"
for i in {1..9}; do
    export FFF_FAV${i}="$GITREPO/fff/fav${i}"
done

#------------------------------
# Alias
#------------------------------
# general alias
alias cat='bat --theme=iceberg'
alias ccat='pygmentize -g -O style=colorful,linenos=1'
alias clock='tty-clock -s -c -C 4'
alias convpdftotxt="pdftotext -layout -nopgbrk"
alias copy='xclip -selection clipboard'
alias copyoneline='xargs echo -n | xclip -selection clipboard'
alias diff='colordiff'
alias df='duf'
alias emptytrash='rm -rf "$HOME/.local/share/Trash"'
alias ff='firefox'
alias grep='grep --color=auto'
alias kp='kill $(ps aux | fzf | awk "{print \$2}")'
alias mcd='f(){ mkdir -p "$1" && cd "$1" }; f'
alias mpv='f(){ mpv "$1" &> /dev/null & }; f'
alias nv='$EDITOR -c ":NV"'
alias ping='prettyping --nolegend'
alias please='sudo $(fc -ln -1)'
alias po='f() { sleep "$1" && systemctl poweroff }; f'
alias rg='rg -i --no-ignore'
alias rm='rm -i'
alias s='export lst=$(ls | tail -1); export fst=$(ls | head -1)'
alias sedremovespace="sed -E '/^[[:space:]]*$/d;s/^[[:space:]]+//;s/[[:space:]]+$//'"
alias subtitle='subliminal download -l en'
alias top='htop'
alias tree='exa --tree'
alias ts='task'
alias u='/usr/bin/up'
alias uc='UCOLLAGE_EXPAND_DIRS=0 UCOLLAGE_SORT_BY=time ucollage'
alias uf='fzfimg.sh'
alias replug='devmon -a'
alias unplug='devmon -u'
alias watchout='f() { fswatch -r -0 --event=Updated "$1" 2>/dev/null | xargs -0 -n 1 zsh -c "$2; date +%H:%M:%S"}; f'
alias y='yay'

# cd
alias cdb="cd $GITREPO/blog"
alias cdf='cd "$(find * -type d | fzf --preview="ls {}" --preview-window=right:70%:wrap)"'
alias cdg="cd $GITREPO"

# ls
alias ls='exa -s mod --git'
alias lsg='exa -s mod --git | rg --'
alias lg='f() { logsave -a "${HOME}/stdout/$(date +%s)" zsh -c "source ~/.zshrc; $1" }; f'
alias llg='exa -l -s mod --git --time-style=long-iso | rg --'
alias ll='exa -l -s mod --git --time-style=long-iso'
alias lw='f() { ls "$1" | wc -l }; f'

# vim
alias vi='$EDITOR'
alias vim='$EDITOR'
alias vif='$EDITOR "$(fzf --bind "enter:abort+execute(echo {2..-1})" --preview="cat {2..-1}" --preview-window=right:70%:wrap)"'
alias vil='$EDITOR $(find ${HOME}/stdout -type f -printf "%T@ %p\n" | sort -n | tail -1 | cut -f2- -d" ")'

# hugo
alias hugos="cd $GITREPO/blog; hugo server -D >/dev/null &"

# python server
alias python-server='ip addr | grep "state UP" -A 2 | grep -Eo "inet [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"; python3 -m http.server 8000'

# miniserve
alias mini-server='ip=$(ip addr | grep "state UP" -A 2 | grep -Eo "inet [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" | awk "{print \$2}"); miniserve -quz -i "$ip" .'

# run firefox or chromium in new instance
alias newchromium='chromium --user-data-dir=$(mktemp -d) &> /dev/null &'
alias newchromiumwithproxy='http_proxy="localhost:8080" https_proxy="localhost:8080" chromium --user-data-dir=$(mktemp -d) &> /dev/null &'
alias newchromiumwithtor='chromium --user-data-dir=$(mktemp -d) --proxy-server="socks5://127.0.0.1:9050" --host-resolver-rules="MAP * 0.0.0.0 , EXCLUDE localhost" &> /dev/null &'
alias newfox='firefox --profile $(mktemp -d) &> /dev/null &'

# grc
if [[ "$TERM" != dumb ]] && (( $+commands[grc] )) ; then
  # Supported commands
  cmds=(
    cc \
    configure \
    cvs \
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

# git
alias g='f() {
    if [[ "$1" == am ]]; then
        git ac
    elif [[ "$1" == clean ]]; then
        git purge
    else
        git "$@"
    fi
}; f'

# calibre
alias calibreadd='f() { calibredb add "$1" -T new }; f'
alias calibreconvert='f() { file="$1"; ebook-convert "$file" "${file%.*}.azw3" --from-opf=metadata.opf --cover=cover.jpg --output-profile=kindle }; f'

# external monitor
alias dispabove='xrandr --output HDMI-1 --mode 1920x1080 --above eDP-1'
alias dispoff='xrandr --output HDMI-1 --off'
alias dispon='xrandr --output HDMI-1 --mode 1920x1080 --same-as eDP-1'

#------------------------------
# Functions
#------------------------------
#/ = <expr>: calculator
= () {
    calc="${*//p/+}"
    calc="${calc//x/*}"
    calc="${calc//,/.}"
    calc "$calc"
}

#/ appsearch <id>: search app in Play Store or App Store by app id
appsearch() {
    if [[ "$1" =~ '^[0-9]+$' ]]; then
        curl -sS -H "X-Apptweak-Key: $APPTWEAK_KEY" "https://api.apptweak.com/ios/applications/$1/metadata.json?language=en&device=iphone" | jq
    else
        curl -sS -H "X-Apptweak-Key: $APPTWEAK_KEY" "https://api.apptweak.com/android/applications/$1/metadata.json?language=en" | jq
    fi
}

#/ appstoresearch <term>: search apps in App Store by term
appstoresearch() { curl -sS -H "X-Apptweak-Key: $APPTWEAK_KEY" "https://api.apptweak.com/ios/searches.json?language=en&device=iphone&term=$1" | jq }

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
antonym() { curl -sS https://www.thesaurus.com/browse/$1| pup 'script text{}' | grep INITIAL_STATE | sed -E 's/.*INITIAL_STATE = //;s/;$//' | sed -E 's/:undefined,/:null,/g'| jq -r '.searchData.tunaApiData.posTabs[] | .definition as $definition | .pos as $pos | .antonyms | sort_by (.term) | .[] | select((.similarity | tonumber)<-51) | "\($pos) \($definition):: \(.term)"' | awk -F"::" '{if ($1==prev) printf ",%s", $2; else printf "\n\n%s\n %s", $1, $2; prev=$1} END {print "\n"}' }

#/ bang [<keyword> <text>]: open DDG bang
bang() {
    if [[ "$1" ]]; then
        xdg-open "https://duckduckgo.com/?q=%21${1}+${2// /+}"
    else
        curl -sS 'https://duckduckgo.com/bang.v255.js' | jq -r '.[] | "\(.t) \(.u)"'
    fi
}

#/ brainyquote <word>: search brainyquote
brainyquote () {
    curl -sS "https://www.brainyquote.com/search_results?q=${1// /+}" | pup '.clearfix text{}' | sedremovespace | sed -E "s/\&#39;/\'/g" | awk 'NR % 2 {print} !(NR % 2) {printf "- %s\n\n",$0 }'
}

#/ buildapk <keystore> <alias>: sign apk
buildapk () { cordova build --release; jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore "$1" android-release-unsigned.apk "$2";zipalign -v 4 android-release-unsigned.apk android-signed.apk;zipalign -c -v 4 android-signed.apk }

#/ chartable <title>: chartable podcast search
chartable () {
    local h o m s t r
    h="https://chartable.com"
    o="$(curl -sS "$h/search?q=${1// /+}" | jq -r '.[]')"
    m=$(jq 'length' <<< "$o")
    for (( i = 0; i < m; i++ )); do
        s=$(jq -r '.[($index|tonumber)].slug' --arg index "$i" <<< "$o")
        t=$(jq -r '.[($index|tonumber)].title' --arg index "$i" <<< "$o")
        r=$(curl -sS "$h/podcasts/$s" | grep "class='gray'" | sed -E 's/stars from /\(/;s/ ratings/\)/' | sed -E "s/<div class='gray'>//;s/<\/div>//")
        if [[ "$r" ]]; then
            printf '%b\n' "\033[33m[$r]\033[0m $t"
        else
            printf '%b\n' "$t"
        fi
    done
}

#/ cht <language> <question>: cheat sheet
cht () { curl "cht.sh/$1/$2" }

#/ citytime <city_name>: show current time in city $1
citytime () { zdump "$(fd -t f -d 2 "$1" /usr/share/zoneinfo/ | tail -1)" }

#/ cpu <keyword>: find CPU info from PassMark: Name; Mark; Rank; Value; Price
cpu () { curl -sS 'https://www.cpubenchmark.net/cpu_list.php' | grep 'cpu_lookup' | sed -e 's/<\/td><\/tr>/\n/g' -e 's/<tr.*multi=\w">//g' -e 's/<\/a><\/td><td>/; /g' -e 's/<\/td><td>/; /g' -e 's/<tr//g' -e 's/><td>//g' | awk -F '>' '{print $2}' | sed -e 's/<a href=.*//g' | grep -i "$1"}

#/ currency <from_currency> <to_currency> <number>: fetch currency exchange rate
currency () { $GITREPO/xe-cli/xe.sh "$1" "$2" "$3" }

#/ dadjoke: show dadjoke
dadjoke () { echo $(curl -sS -H "Accept: text/plain" https://icanhazdadjoke.com/)'\n' }

#/ doomsday <yyyy>: calculate doomsday of a given year
doomsday() {
    local year="$1"
    local century="${year:0:2}"
    local decade="${year:2:3}"
    local doomsdaycenturyarray=(5 3 2 0)
    local doomsdaycentury="${doomsdaycenturyarray[$(((century-10)%4+1))]}"

    local isleap=""
    if [[ $((year % 4)) -ne 0 ]] ; then
        :
    elif [ $((year % 400)) -eq 0 ] ; then
        isleap="leap"
    elif [ $((year % 100)) -eq 0 ] ; then
        :
    else
        isleap="leap"
    fi

    echo "$(((decade/12 + decade%12 + decade%12/4 + doomsdaycentury) %7 )) $isleap"
}

#/ douban <movie_name>: douban movie search
douban () {
    local o m s t r rc
    o=$($GITREPO/putility/putility.js "https://search.douban.com/movie/subject_search?search_text=$1" -w 100)
    m=$(grep -co sc-bZQynM <<< "$o")
    for (( i = 0; i < m; i++ )); do
        s=$(pup '.sc-bZQynM:nth-child('$((i+1))')' <<< "$o")
        if [[ "$s" ]]; then
            t=$(pup '.title-text text{}' <<< "$s" | sedremovespace | sed -E "s/\&#39;/\'/g")
            r=$(pup '.rating_nums text{}' <<< "$s" | sedremovespace)
            rc=$(pup '.pl text{}' <<< "$s" | sedremovespace)
            if [[ "$r" ]]; then
                printf "%b\n" "\033[33m[$r $rc]\033[0m $t"
            else
                printf "%b\n" "$t"
            fi
        fi
    done
}

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

#/ getlinks <url>: get all links on the page
getlinks () { curl -sS "$1" | pup 'a, link, base, area attr{href}' | sedremovespace | sort -u }

#/ goodreads <book>: goodreads search
goodreads () {
    local o m s t st a
    o=$(curl -sS "https://www.goodreads.com/search?q=${1// /+}")
    m=$(grep -c "role='heading'" <<< "$o")
    for (( i = 0; i < m; i++ )); do
        s=$(pup 'tr:nth-child('$((i+1))')' --charset utf-8 <<< "$o")
        t=$(pup '.bookTitle text{}' <<< "$s" | sedremovespace | sed -E "s/\&#39;/\'/g")
        st='\033[33m'$(sed -E '/rel="nofollow"/{n;d}' <<< "$s" | sed -E '/class="staticStar p10"/{n;d}' | pup '.smallText text{}' --charset utf-8 | sedremovespace | awk '{printf " %s", $0}' | sed -E 's/ avg rating//' | sed -E 's/ ratings* —/\)\\033\[0m/;s/ — / \(/;s/ —$//' | sedremovespace | sed -E "s/\&#39;/\'/g")
        a=$(pup '.authorName text{}' <<< "$s" | sedremovespace | awk '{printf " %s", $0}' | sedremovespace | sed -E "s/\&#39;/\'/g")
        printf "%b\n" "\033[32m$t\033[0m by $a - $st"
    done
}

#/ help <keyword>: list functions
help () { grep "^#/" "${HOME}/.zshrc" | cut -c4- | rg -i "${@:-}" }

#/ holiday <country_code> <year>: list of public holidays in country $1 in year $2
holiday () { [[ -z $2 ]] && y=$(date "+%Y") || y="$2"; curl -s "https://date.nager.at/Api/v2/PublicHolidays/$y/$1" | jq -r '.[] | "\(.date) \(.localName) - \(.name)"' }

#/ httpstatus: show HTTP code explanation, $1 HTTP code
httpstatus () { curl -i "https://httpstat.us/$1" }

#/ httpstatuslist: show list of HTTP codes
httpstatuslist () { curl -s 'https://httpstat.us/' | pup -p 'dl text{}' | sedremovespace | awk 'NR%2{printf "%s ",$0;next}{print}' }

#/ imdb <title>: imdb search
imdb () {
    local tt i s t st r rc
    tt=$(awk '{print tolower($0)}' <<< "$1")
    while read -r i; do
        if [[ "$i" == "tt"* ]]; then
            s=$(curl -sS "https://www.imdb.com/title/$i/")
            t=$(pup 'h1 text{}' --charset utf-8 <<< "$s" | sedremovespace |  awk '{printf $0}' | sed -E "s/\&#39;/\'/g")
            st=$(pup '.subtext text{}' --charset utf-8 <<< "$s" | sedremovespace | awk '{printf $0}' | sed -E "s/\&#39;/\'/g")
            r=$(pup '.ratingValue text{}' <<< "$s" | sedremovespace | head -1)
            rc=$(pup 'span[itemprop="ratingCount"] text{}' <<< "$s")
            if [[ "$r" ]]; then
                printf "%b\n" "\033[33m[$r ($rc)]\033[0m \033[32m$t\033[0m - $st"
            else
                printf "%b\n" "\033[32m$t\033[0m - $st"
            fi
        fi
    done <<< $(curl -sS "https://v2.sg.media-imdb.com/suggestion/${tt:0:1}/${tt// /_}.json" | jq -r '.d[].id')
}

# jsonpath: command to print each path/value pair
jsonpath() { jq -r 'paths(scalars) as $p | "." + ([([$p[] | tostring] | join(".")), (getpath($p) | tojson)] | join(": "))' }

# letterboxd <film_name>: search film on letterboxd
letterboxd() {
    local o m t y l j g r
    o=$(curl -sS "https://letterboxd.com/search/films/${1// /+}/" | pup '.results')
    m=$(grep -c 'class="film-detail-content"' <<< "$o")
    [[ "$m" -gt "10" ]] && m=10
    for (( i = 0; i < m; i++ )); do
        t=$(pup 'li:nth-child('"$((i+1))"') > div:nth-child(2) > h2:nth-child(1) > span:nth-child(1) > a:nth-child(1) text{}' <<< "$o" | sedremovespace)
        y=$(pup 'li:nth-child('"$((i+1))"') > div:nth-child(2) > h2:nth-child(1) > span:nth-child(1) > small:nth-child(2) > a:nth-child(1) text{}' <<< "$o" | sedremovespace)
        l=$(pup 'li:nth-child('"$((i+1))"') > div:nth-child(2) > h2:nth-child(1) > span:nth-child(1) > a:nth-child(1) attr{href}' <<< "$o" | sedremovespace)
        if [[ $l ]]; then
            j=$(curl -sS "https://letterboxd.com${l}" | grep ratingValue)
            g=$(jq -r '.genre | join(", ")' <<< "$j")
            r=$(jq -r '.aggregateRating | "\(.ratingValue) (\(.ratingCount))"' <<< "$j")
            printf '%b\n' "$y $t \033[33m$r\033[0m $g"
        else
            printf '%b\n' "$y $t"
        fi
    done
}

#/ lm: show last modified time of sites, defined in ${HOME}/.site
lm () {
    for url in $(cat "${HOME}/.site"); do
        echo "> $url"
        time=$(curl -Is "$url" | grep last | cut -c16-)
        echo "\t"$(date -d $time)
    done
}

#/ lyrics <word>: search lyrics
lyrics () {
    local o m s t a l
    o=$(curl -sS "https://www.lyrics.com/lyrics/${1// /%20}" | sed -E 's/\r$/---/g' | pup '.sec-lyric')
    m=$(grep -c '.sec-lyric' <<< "$o")
    [[ "$m" -gt 11 ]] && m=10

    for (( i = 0; i < m; i++ )); do
        s=$(pup 'div.sec-lyric:nth-child('"$((i+1))"')' <<< "$o")
        t=$(pup '.lyric-meta-title text{}' <<< "$s" | sedremovespace)
        a=$(pup '.lyric-meta-album-artist text{}' <<< "$s" | sedremovespace)
        [[ "$a" == "" ]] && a=$(pup '.lyric-meta-artists text{}' <<< "$s" | sedremovespace)
        l=$(pup --charset utf-8 '.lyric-body text{}' <<< "$s" | sedremovespace | awk '{printf "%s ",$0}' | sed -E 's/---/\n/g' | sedremovespace)
        printf '\n%b\n' "\033[32m$t\033[0m - $a\n$l" | sed -E "s/\&#39;/\'/g"
    done
}

#/ mangaupdate <manga_name>: search mangaupdate
mangaupdate () {
    local o m t y r
    o=$(curl -sS "https://www.mangaupdates.com/series.html?search=${1// /+}&display=list&type=manga&perpage=20" | pup 'div.p-2:nth-child(2) > div:nth-child(2)')
    m=$(grep -c 'py-1' <<< "$o")
    for (( i = 0; i < m; i++ )); do
        t=$(pup 'div.py-1:nth-child('"$((i*4+6))"') text{}' <<< "$o" | sedremovespace)
        y=$(pup 'div.col-1:nth-child('"$((i*4+8))"') text{}' <<< "$o" | sedremovespace)
        r=$(pup 'div.col-1:nth-child('"$((i*4+9))"') text{}' <<< "$o" | sedremovespace)
        [[ ! "$r" ]] && r="n/a "
        printf '%b\n' "\033[33m[$r]\033[0m $y $t"
    done
}

#/ myanimelist <anime_name>: search anime info
myanimelist () { printf "$(curl -sS "https://myanimelist.net/search/prefix.json?type=all&keyword=${1// /%20}&v=1" | jq -r '.categories[] | select (.type == "anime" or .type == "manga") | .items[] | "\\033[33m[\(.payload.score)]\\033[0m+\(.name)++\(.payload.media_type)+\(.payload.aired)+\(.payload.published)"' | sed -E 's/\+null//' | column -t -s '+')" }

#/ myip: show my ip address
myip () { curl -4 'icanhazip.com'; curl -6 'icanhazip.com' }

#/ mytimezone: show my timezone
mytimezone () { curl -s 'https://ipapi.co/timezone' }

#/ mytraceroute: returns a traceroute from my servers to my ip address
mytraceroute () { curl 'icanhaztraceroute.com' }

#/ mytrafficproxied : determine if my taffic is proxied or not
mytrafficproxied () { curl 'icanhazproxy.com' }

#/ outline <url>: generate outline link
outline() {
    local u=$(curl -sS "https://api.outline.com/v3/parse_article?source_url=$1" -H 'Referer: https://outline.com/' | jq -r '.data.short_code')
    xdg-open "https://outline.com/$u"
}

#/ playstoresearch <term>: search apps in Play Store by term
playstoresearch() { curl -sS -H "X-Apptweak-Key: $APPTWEAK_KEY" "https://api.apptweak.com/android/searches.json?language=en&term=$1" | jq }

#/ port <port_number>: port lookup
port () { curl -sS 'https://www.portcheckers.com/port-number-assignment' --data-raw port="$1" | grep '<tr><td>' | sed -E 's/<[\/]?t[rd]>/ /g' | sedremovespace }

#/ qotd: quote of the day
qotd () { curl -s 'https://favqs.com/api/qotd' | jq -r '.quote | "\"\(.body)\" - \(.author)"'; echo }

#/ quodb <quote>: movie quote search
quodb () { printf "$(curl -sS "http://api.quodb.com/search/${1// /%20}?page=1&titles_per_page=50&phrases_per_title=1" | jq -r '.docs[] | "\\033[32m\(.phrase)\\033[0m - \(.title) \(.year)"')" }

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

#/ rottentomatoes <title>: rottentomatoes search
rottentomatoes () {
    o=$(curl -sS "https://www.rottentomatoes.com/napi/search/?limit=30&query=${1// /%20}")
    r=$(jq -r '.movies[] | "\\033[33m[\(.meterScore)]\\033[0m+++\(.year)+++\(.name)"' <<< "$o")"\n"
    r="$r"$(jq -r '.tvSeries[] | "\\033[33m[\(.meterScore)]\\033[0m+++\(.startYear)-\(.endYear)+++\(.title)"' <<< "$o")
    r=$(sed -E 's/\[null\]/\[n\/a\]/;s/-null\+\+\+/-\+\+\+/;s/\+\+\+null-/\+\+\+-/' <<< "$r")
    printf '%b' "$r" | column -t -s '+++'
}

#/ savepage <url>: save webpage to one single HTML file
savepage() { monolith "$1" > $(date +%s).html }

#/ screenshot: take screenshot
screenshot () { import -quiet -pause 2 $(date +%s).jpg }

#/ showpath: show PATH
showpath () { awk -v RS=: '{print}' <<<$PATH }

#/ synonym <word>: search for synonym of a word
synonym() { curl -sS https://www.thesaurus.com/browse/$1| pup 'script text{}' | grep INITIAL_STATE | sed -E 's/.*INITIAL_STATE = //;s/;$//' | sed -E 's/:undefined,/:null,/g' | jq -r '.searchData.tunaApiData.posTabs[] | .definition as $definition | .pos as $pos | .synonyms | sort_by (.term) | .[] | select((.similarity | tonumber)>49) | "\($pos) \($definition):: \(.term)"' | awk -F"::" '{if ($1==prev) printf ",%s", $2; else printf "\n\n%s\n %s", $1, $2; prev=$1} END {print "\n"}' }

#/ tinyurl <url>: shorten url using tinyurl
tinyurl()  {
    local u=$(curl -sS "https://tinyurl.com/create.php?source=index&alias=&url=$1" | grep '://tinyurl.com/' | grep 'target' | grep -E 'https://tinyurl.com/\w+' -o | head -1)
    echo -n "$u" | xclip -selection clipboard
}

#/ toc <file.md>: add table of coentents in markdown file
toc() {
    local t out
    t=$(cat "$1" | grep -v "# Table of Contents" | grep -E '^#' | sed -E 's/# /- [/' | sed -E 's/#/  /g' | sed -E 's/$/]/' | sed -E 's/\[(.*)\]/\[\1](#\L\1/')
    while grep -q '#.* ' <<< "$t"; do
        t=$(sed -E 's/(.*#.*)\s+/\1-/' <<< "$t")
    done
    while grep -q '#.*[^a-zA-Z0-9_-]' <<< "$t"; do
        t=$(sed -E 's/(.*#.*)[^a-zA-Z0-9_-]+/\1/' <<< "$t")
    done
    t=$(sed -E 's/$/)/' <<< "$t")
    out=$(mktemp)
    echo -e "# Table of Contents\n\n$t\n" > "$out"
    cat "$1" >> "$out"
    mv "$out" "$1"
}

#/ unshorten <url>: reveal shortened URL
unshorten() { curl -sSL -I "$1" | grep 'Location: ' | awk -F ': ' '{print $2}' }

#/ v <img> [viu params]: display image in terminal
v () { [[ "$(echo $1 | tr '[a-z]' '[A-Z]')" =~ (CR2|DNG)$ ]] && dcraw -c -w "$1" | cjpeg | viu "${@:2}" || viu "$@" }

#/ weather <location>: get weather info
weather () { curl "wttr.in/$1" }

#/ weatherhourly <location>: get hourly weather info
weatherhourly () {
    coordinate=$(curl -sS "https://darksky.net/geo?q=${1// /%20}" | jq -r '"\(.latitude),\(.longitude)"')
    printf "%b: %b\n" "\e[33m$1" "$coordinate\e[0m"

    result=$(curl -sS "https://darksky.net/details/$coordinate/$(date +%s)/ca12/en.json")
    printf "\n\e[33mCURRENTLY\e[0m\n"
    echo "$result" | jq -r '.currently | "\(.time | localtime | strftime("%m-%d %H:%M"))+\(.temperature|round)°C+\(.summary)+\(.precipProbability*100|round)%"' | column -t -s'+'
    printf "\n\e[33mTODAY HOURLY\e[0m\n"
    echo "$result" | jq -r '.hourly.data[] | select(.time > ($t | tonumber)) | "\(.time | localtime | strftime("%m-%d %HH"))+\(.temperature|round)°C+\(.summary)+\(.precipProbability*100|round)%"' --arg t "$(date -d '1 hour ago' +%s)" | column -t -s'+'

    printf "\n\e[33mTOMORROW HOURLY\e[0m\n"
    curl -sS "https://darksky.net/details/$coordinate/$(date --date='next day' +%s)/ca12/en.json" | jq -r '.hourly.data | .[] | "\(.time | localtime | strftime("%m-%d %HH"))+\(.temperature|round)°C+\(.summary)+\(.precipProbability*100|round)%"' | column -t -s'+'
}

#/ whatcms: show cms used by website $1
whatcms () { curl -sS "https://whatcms.org/APIEndpoint/Detect?key=$(cat $WHATCMS_KEY_FILE | shuf | tail -1)&url=$1" | jq . }

#/ whohosts: show host info of website $1
whohosts () { curl -sS "https://www.who-hosts-this.com/APIEndpoint/Detect?key=$(cat $WHATCMS_KEY_FILE | shuf | tail -1)&url=$1" | jq . }

#/ yd <url>: download youtube video, max. resolution 1080
yd () { youtube-dl -f 'bestvideo[height<=?1080][fps<=?30]+bestaudio/best' $(sed -E 's/.*www.youtube/https:\/\/www.youtube/' <<< "$1" | sed -E 's/%2F/\//g;s/%3F/\?/g;s/%3D/\=/g' | sed -E 's/\&list=.*//') }

#/ yd720 <url>: download youtube video, max. resolution 720
yd720 () { youtube-dl -f 'bestvideo[height<=?720][fps<=?30]+bestaudio/best' $(sed -E 's/.*www.youtube/https:\/\/www.youtube/' <<< "$1" | sed -E 's/%2F/\//g;s/%3F/\?/g;s/%3D/\=/g' | sed -E 's/\&list=.*//') }

#/ yda <url>: download youtube audio
yda () { youtube-dl -x $(sed -E 's/.*www.youtube/https:\/\/www.youtube/' <<< "$1" | sed -E 's/%2F/\//g;s/%3F/\?/g;s/%3D/\=/g' | sed -E 's/\&list=.*//') }

#/ yds <url>: download youtube with subtitle
yds () { youtube-dl --write-auto-sub --convert-subs=srt --sub-lang en,en-US $(sed -E 's/.*www.youtube/https:\/\/www.youtube/' <<< "$1" | sed -E 's/%2F/\//g;s/%3F/\?/g;s/%3D/\=/g' | sed -E 's/\&list=.*//') }

#/ youtuberss <url>: get YouTube RSS QR code
youtuberss () { url=$(curl -s "$1" | pup 'link' | grep RSS | sed -e 's/^.*href="//' | sed -e 's/">.*$//'); echo "$url"; qr "$url"}

#/ yuicss <css_file>: css compressor
yuicss () { echo "$1".css; rm -f $1.min.css; java -jar ${HOME}/Script/yuicompressor-2.4.8.jar --type css "$1".css > "$1".min.css;}
#/ yuijs <js_file>: js compressor
yuijs () { echo "$1".js; rm -f $1.min.js; java -jar ${HOME}/Script/yuicompressor-2.4.8.jar --type js "$1".js > "$1".min.js;}

#/ zipundo <zip_file>: clean unzip mess
zipundo () { unzip -Z -1 "$1" | xargs -I{} rm -v {} }

#------------------------------
# History
#------------------------------
HISTFILE="${HOME}/.histfile"
HISTSIZE=10000
SAVEHIST=10000
h() { [ -z "$*" ] && history -i 1 || history -i 1 | egrep "$@" }

# share history
setopt share_history
setopt inc_append_history

#-----------------------------
# Dircolors
#-----------------------------
[[ -f "${HOME}/.dir_colors" ]] && eval `dircolors ${HOME}/.dir_colors`

#------------------------------
# Completion
#------------------------------
autoload -Uz compinit
compinit
setopt completealiases
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' file-sort modification
zstyle ':completion:complete:*:argument-rest' sort false
zstyle ':fzf-tab:*' fzf-bindings 'tab:down,btab:up,ctrl-j:up,ctrl-k:down,change:top,alt-space:toggle,space:accept,ctrl-a:select-all,ctrl-u:deselect-all'

#------------------------------
# ZSH Plugins
#------------------------------
source "${HOME}/.zsh/fzf-tab/fzf-tab.plugin.zsh"
source "${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "${HOME}/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh"
source "${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "${HOME}/.zsh/fzf/completion.zsh"
source "${HOME}/.zsh/fzf/key-bindings.zsh"
source "${HOME}/.zsh/fzf/command-snippet.zsh"
source "${HOME}/.zsh/up.sh"
source "${HOME}/.zsh/z.lua.plugin.zsh"
source "${HOME}/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

export HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
export HISTORY_SUBSTRING_SEARCH_FUZZY=1
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=8,fg=221,bold'
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=1,bold'

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

    printf '%s\n' "${all_command_array[@]}" | sort -u | sedremovespace
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

show_args_in_prev_hundred_commands() {
    sel=$(fetch_history_commands 100 | fzf_in_widget)
    zle redisplay
    [[ -n "$sel" ]] && LBUFFER="${LBUFFER}${sel} "
    return 0
}

zle -N show_args_in_prev_command
zle -N show_args_in_prev_ten_commands
zle -N show_args_in_prev_hundred_commands

function zle-keymap-select zle-line-finish {
    case $KEYMAP in
        vicmd) print -n -- "\e[4 q";;
        viins) pinrt -n -- "\e[4 q";;
        main)  print -n -- "\e[6 q";;
    esac
    zle reset-prompt
    zle -R
}

function zle-line-init {
    print -n -- "\e[6 q"
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

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
bindkey "^[l" forward-char
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
bindkey "^[3" show_args_in_prev_hundred_commands
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
[[ -f "${HOME}/.czshrc" ]] && source "${HOME}/.czshrc"

[ -f ~/.devicons.sh ] && source ~/.devicons.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
