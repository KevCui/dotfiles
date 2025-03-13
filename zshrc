#------------------------------
# Variables
#------------------------------
export PATH="$PATH":${HOME}/Script:${HOME}/.cabal/bin:${HOME}/.npm-global/bin:${HOME}/.local/bin:${HOME}/go/bin:${HOME}/.cargo/bin
export TERM='xterm-256color'
export EDITOR="nvim"
export sys=/etc/systemd/system
export libsys=/usr/lib/systemd/system
export pkg=/var/cache/pacman/pkg
export GPG_TTY=$(tty)
export GITREPO="${HOME}/git"
export SNIPPET="${HOME}/Notes/command-snippet.md"
export WORDCHARS="*?_-.[]~=&;!#$%^(){}<>|'\""

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
  --no-separator
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
alias chist='head -n -2 $HOME/.histfile > /tmp/histfile && mv /tmp/histfile $HOME/.histfile'
alias clock='tty-clock -s -c -C 4'
alias convpdftotxt="pdftotext -layout -nopgbrk"
alias copy='xclip -selection clipboard'
alias copyoneline='xargs echo -n | xclip -selection clipboard'
alias diff='colordiff'
alias df='duf -hide-fs tmpfs'
alias emptytrash='rm -rf "$HOME/.local/share/Trash"'
alias ff='firefox'
alias grep='grep --color=auto'
alias kp='kill $(ps aux | fzf | awk "{print \$2}")'
lg() { logsave -a "${HOME}/stdout/$(date +%s)" zsh -c "source ~/.zshrc; $1" }
alias md='rich -m $1'
mpv() { /usr/bin/mpv "$1" &> /dev/null & }
alias nv='$EDITOR -c ":NV"'
alias ping='prettyping --nolegend'
alias please='sudo $(fc -ln -1)'
po() { sleep "$1" && systemctl poweroff }
alias q='qutebrowser'
alias rg='rg -i --no-ignore'
alias rm='rm -i'
alias s='export lst=$(ls | tail -1); export fst=$(ls | head -1)'
alias sedremovespace="sed -E '/^[[:space:]]*$/d;s/^[[:space:]]+//;s/[[:space:]]+$//'"
alias subtitle='subliminal download -l en'
alias top='htop'
alias tree='exa --tree'
alias ts='task'
alias uc='UCOLLAGE_EXPAND_DIRS=0 UCOLLAGE_SORT_BY=time ucollage'
alias uf='fzfimg.sh'
watchout() { fswatch -r -0 --event=Updated "$1" 2>/dev/null | xargs -0 -n 1 zsh -c "$2; date +%H:%M:%S"}
alias y='yay'

# cd
alias cdb="cd $GITREPO/blog"
alias cdf='cd "$(find * -type d | fzf --preview="ls {}" --preview-window=right:70%:wrap)"'
alias cdg="cd $GITREPO"

# ls
alias ls='exa -s mod --git'
alias lsg='exa -s mod --git | rg --'
alias llg='exa -l -s mod --git --time-style=long-iso | rg --'
alias ll='exa -l -s mod --git --time-style=long-iso'
lw() { ls "$1" | wc -l }
l() { [[ -z "${1:-}" ]] && ll || llg "$1" }

# vim
alias vi='$EDITOR'
alias vim='$EDITOR'
alias vif='$EDITOR "$(fzf --bind "enter:abort+execute(echo {2..-1})" --preview="cat {2..-1}" --preview-window=right:70%:wrap)"'
alias vil='$EDITOR $(find ${HOME}/stdout -type f -printf "%T@ %p\n" | sort -n | tail -1 | cut -f2- -d" ")'

# hugo
alias hugos="cd $GITREPO/blog; hugo server -D &"

# python server
alias python-server='ip addr | grep "state UP" -A 2 | grep -Eo "inet [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"; python3 -m http.server 8000'

# miniserve
alias mini-server='ip=$(ip addr | grep "state UP" -A 2 | grep -Eo "inet [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" | tail -1 | awk "{print \$2}"); miniserve -u -qz -i "$ip" .'

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
g() {
    if [[ "$1" == am ]]; then
        git ac
    elif [[ "$1" == clean ]]; then
        git purge
    else
        git "$@"
    fi
}

# calibre
calibreadd() { calibredb add "$1" -T new }
calibreconvert() { file="$1"; ebook-convert "$file" "${file%.*}.azw3" --from-opf=metadata.opf --cover=cover.jpg --output-profile=kindle }

# external monitor
alias dispabove='xrandr --output HDMI-1 --mode 1920x1080 --above eDP-1'
alias dispoff='xrandr --output HDMI-1 --off'
alias dispon='xrandr --output HDMI-1 --mode 1920x1080 --same-as eDP-1'

#------------------------------
# Functions
#------------------------------
#/ = <expr>: calculator
= () {
    local calc r
    calc="${*//p/+}"
    calc="${calc//x/*}"
    calc="${calc//,/.}"
    calc="${calc//o/0}"
    calc="${calc//y/1}"
    calc="${calc//e/2}"
    calc="${calc//s/3}"
    calc="${calc//i/4}"
    calc="${calc//w/5}"
    calc="${calc//l/6}"
    calc="${calc//q/7}"
    calc="${calc//b/8}"
    calc="${calc//j/9}"
    echo "$calc"
    r="$(echo "scale=10; $calc" | bc)"
    echo "scale=2; ($r)/1" | bc
}

#/ addpet: add command snippet to $SNIPPET
addpet () {
    read "?Command: " cmdinput
    read "?Description: " desinput
    echo "[$desinput]: $cmdinput" >> $SNIPPET
}

#/ alpha: print alphabet letters
alpha () {
    local n o=""
    for x in {a..z}; do
        n="$(($(printf "%d" "'$x")-96))"
        o+="|$n\t$x\t"
        [[ $((n % 5 )) -eq 0 ]] && o+="\n"
    done
    echo -e "$o"
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

#/ cpu <keyword>: find CPU info from PassMark: Name; Mark; Rank; Value; Price
cpu () {
    local out
    out="Name;;Mark;;Rank;;Value;;Price"$'\n'
    out+="$(curl -sS 'https://www.cpubenchmark.net/cpu_list.php' | grep 'cpu_lookup' | sed 's/<\/td/;;<\/td/g' | htmlq -t | grep -i "$1")"
    column -t -s ';;' <<< "$out"
}

#/ cve <CVE-ID>: list CVE details
cve () {
    local data="$(curl -sS "https://nvd.nist.gov/vuln/detail/${1:u}" --compressed)"
    htmlq -t 'p[data-testid="vuln-description"]' <<< "$data" | sedremovespace
    echo "---"
    htmlq -t '#Cvss3NistCalculatorAnchor' <<< "$data" | sedremovespace
    htmlq -t '.tooltipCvss3NistMetrics' <<< "$data" | sedremovespace
    local cScore="$(htmlq -t '#Cvss3CnaCalculatorAnchor' <<< "$data" | sedremovespace)"
    if [[ -n "${cScore:-}" ]]; then
        echo "CNA: $cScore"
        htmlq -t '.tooltipCvss3CnaMetrics' <<< "$data" | sedremovespace
    fi
    echo "---"
    htmlq -t '#vulnHyperlinksPanel table td' <<< "$data" | grep http | sedremovespace
    echo "---"
    htmlq -t '#vulnTechnicalDetailsDiv table td' <<< "$data" | sedremovespace
    echo "---"
    htmlq -t '#cveTreeJsonDataHidden' -a value <<< "$data" | sed -E 's/\&#34;/"/g' | jq -r '.[].containers[].cpes[] | "\(.cpe23Uri) \(.rangeDescription)"'
}

#/ dadjoke: show dadjoke
dadjoke () { echo $(curl -sS -H "Accept: text/plain" https://icanhazdadjoke.com/)'\n' }

#/ datediff <date1> <date2>: calculate date diff
datediff () {
    local d1="$(date -u -d "$1" +%s)"
    local d2="$(date -u -d "$2" +%s)"
    echo "$(( (d2 - d1) / 86400 ))"
}

#/ defaultpassword <keyword>: search default password from a keyword
defaultpassword() { curl -sS 'https://raw.githubusercontent.com/many-passwords/many-passwords/main/passwords.csv' | rg "$1|Vendor,Model" | column -t -s ',' }

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
getlinks () { curl -sS "$1" | htmlq 'a, link, base, area' -a  href | sedremovespace | sort -u }

#/ getproxy: get working proxy
getproxy () {
    local ip
    while read -r line; do
        if [[ -n "${line:-}" ]]; then
            ip="$(awk -F ':' '{print $1}' <<< "$line")"
            if [[ "$(curl -sS ifconfig.me -x "http://$line" --connect-timeout 3 2>/dev/null)" == "$ip" ]]; then
                echo "$line"
            fi
        fi
    done <<< "$(curl -sS 'https://free-proxy-list.net/' | htmlq -t .form-control | sed 's/.*[[:alpha:]].*//')"
}

#/ goodreads <book>: goodreads search
goodreads () {
    local o m s t st a
    o=$(curl -sS "https://www.goodreads.com/search?q=${1// /+}")
    m=$(grep -c "role='heading'" <<< "$o")
    for (( i = 0; i < m; i++ )); do
        s=$(htmlq 'tr:nth-child('$((i+1))')' <<< "$o")
        t=$(htmlq -t '.bookTitle' <<< "$s" | sedremovespace | sed -E "s/\&#39;/\'/g")
        st='\033[33m'$(sed -E '/rel="nofollow"/{n;d}' <<< "$s" | sed -E '/class="staticStar p10"/{n;d}' | htmlq -t '.smallText' | sedremovespace | awk '{printf " %s", $0}' | sed -E 's/ avg rating//' | sed -E 's/ ratings* —/\)\\033\[0m/;s/ — / \(/;s/ —$//' | sedremovespace | sed -E "s/\&#39;/\'/g")
        a=$(htmlq -t '.authorName' <<< "$s" | sedremovespace | awk '{printf " %s", $0}' | sedremovespace | sed -E "s/\&#39;/\'/g")
        printf "%b\n" "\033[32m$t\033[0m by $a - $st"
    done
}

#/ grok <text>: Grok 3
grok () {
    read_output() {
        local d
        while true; do
            [[ ! -f "$1" ]] && return
            d="$(cat $1)"
            clear
            echo -e "$(tr -d '\n' <<< "$d" | sed 's/\\\"/"/g')"
            sleep 0.5
        done
    }

    local c a f
    c="$(shuf < "$HOME/.grokie" | tail -1)"
    a="$(shuf < "$HOME/.useragent" | tail -1)"
    f="$(mktemp)"

    setopt NO_MONITOR
    read_output "$f" 2>/dev/null &

    curl-impersonate -sS -N 'https://grok.com/rest/app-chat/conversations/new' \
      -H "cookie: sso=$c" \
      -A "$a" \
      --data-raw '{"temporary":true,"modelName":"grok-3","message":"'"$1"'","fileAttachments":[],"imageAttachments":[],"disableSearch":false,"enableImageGeneration":false,"returnImageBytes":false,"returnRawGrokInXaiRequest":false,"enableImageStreaming":false,"imageGenerationCount":4,"forceConcise":false,"toolOverrides":{},"enableSideBySide":false,"isPreset":false,"sendFinalMetadata":false,"customInstructions":"","deepsearchPreset":"","isReasoning":false}'  \
      | grep --line-buffered '{"token"' \
      | sed -u 's/.*{"token":"//;s/","isThinking.*//' > "$f"
    sleep 1
    rm -f "$f"
}

#/ h1 <keyword>: search disclosed report from h1
h1() {
    local res session csrftoken
    res="$(wget -qO- 'https://hackerone.com/hacktivity' --debug 2>&1)"
    session="$(grep Host-session <<< "$res" | sed 's/.*Host-session //' | tail -1)"
    csrftoken="$(grep csrf <<< "$res" | grep -v authenticity | sed 's/.*content="//;s/".*//')"

    curl -sS 'https://hackerone.com/graphql' \
      -H 'content-type: application/json' \
      -H "x-csrf-token: $csrftoken" \
      -H "cookie: __Host-session=$session" \
      -d '{"query":"query HacktivityPageQuery($querystring: String, $orderBy: HacktivityItemOrderInput, $secureOrderBy: FiltersHacktivityItemFilterOrder, $where: FiltersHacktivityItemFilterInput, $count: Int, $cursor: String) {\n  hacktivity_items(first: $count, after: $cursor, query: $querystring, order_by: $orderBy, secure_order_by: $secureOrderBy, where: $where) {\n    total_count\n    ...HacktivityList\n  }\n}\n\nfragment HacktivityList on HacktivityItemConnection {\n  edges {\n    node {\n      ... on HacktivityItemInterface {\n        ...HacktivityItem\n      }\n    }\n  }\n}\n\nfragment HacktivityItem on HacktivityItemUnion {\n\n  ... on Disclosed {\n    ...HacktivityItemDisclosed\n  }\n  ... on HackerPublished {\n    ...HacktivityItemHackerPublished\n  }\n}\n\nfragment HacktivityItemDisclosed on Disclosed {\n  report {\n    title\n    url\n  substate\n  }\n  latest_disclosable_activity_at\n  severity_rating\n}\n\nfragment HacktivityItemHackerPublished on HackerPublished {\n  report {\n    title\n    url\n  substate\n  }\n  latest_disclosable_activity_at\n  severity_rating\n}","variables":{"querystring":"'"$1"'","where":{"report":{"disclosed_at":{"_is_null":false}}},"orderBy":{"field":"popular","direction":"DESC"},"secureOrderBy":null,"count":100},"operationName":"HacktivityPageQuery"}' \
    | jq -r '.data.hacktivity_items.edges[].node.report'
}

#/ help <keyword>: list functions
help () { grep "^#/" "${HOME}/.zshrc" | cut -c4- | rg -i "${@:-}" }

#/ holiday <country_code> <year>: list of public holidays in country $1 in year $2
holiday () { [[ -z $2 ]] && y=$(date "+%Y") || y="$2"; curl -s "https://date.nager.at/Api/v2/PublicHolidays/$y/$1" | jq -r '.[] | "\(.date) \(.localName) - \(.name)"' }

#/ howlongtobeat <name>: search how long to beat a game
howlongtobeat () {
    local fn id d jf s
    fn="$(curl -sS 'https://howlongtobeat.com/' -A 'x' | grep _app | sed 's/.*\/pages\/_app/_app/' | sed 's/\" .*//')"
    jf="$(curl -sS "https://howlongtobeat.com/_next/static/chunks/pages/$fn" -A 'x')"
    s="$(grep -Eo '"/api/\w+/"' <<< "$jf" | grep -v 'game' | sed 's/"//g')"
    id="$(sed 's;.*'"$s"';;' <<< "$jf" | sed 's/,.*//' | awk -F '"' '{print $3$5}')"
    d="$(curl -sS "https://howlongtobeat.com${s}${id}" -A 'x' \
        -H 'content-type: application/json' \
        -H 'referer: https://howlongtobeat.com/' \
        --data-raw '{"searchType":"games","searchTerms":["'"${1// /\",\"}"'"],"searchPage":1,"size":20,"searchOptions":{"games":{"userId":0,"platform":"","sortCategory":"popular","rangeCategory":"main","rangeTime":{"min":null,"max":null},"gameplay":{"perspective":"","flow":"","genre":"","difficulty":""},"rangeYear":{"min":"","max":""},"modifier":""},"users":{"sortCategory":"postcount"},"lists":{"sortCategory":"follows"},"filter":"","sort":0,"randomizer":0},"useCache":false}' \
        |  jq -r '.data[] | "\\033[32m\(.game_name)\\033[0m|\\033[33m\(.comp_main/3600 *10.0|round/10)|\(.comp_plus/3600 *10.0|round/10)|\(.comp_100/3600 *10.0|round/10)\\033[0m|\\033[34m\(.review_score)\\033[0m"' \
        | column -t -s '|')"
    printf "%b\n" "$d"
}

#/ httpstatus: show HTTP code explanation, $1 HTTP code
httpstatus () { curl -i "https://httpstat.us/$1" }

#/ httpstatuslist: show list of HTTP codes
httpstatuslist () { curl -s 'https://httpstat.us/' | htmlq -t 'dl' | sedremovespace | awk 'NR%2{printf "%s ",$0;next}{print}' }

#/ imdb <title>: imdb search
imdb () {
    local tt i s t dp du ge r rc
    tt=$(awk '{print tolower($0)}' <<< "$1")
    while read -r i; do
        if [[ "$i" == "tt"* ]]; then
            s="$(curl -sS "https://www.imdb.com/title/$i/" -A imdb | htmlq -t 'script' | grep '"@context')"
            t="$(jq -r .name <<< "$s")"
            dp="$(jq -r .datePublished <<< "$s")"
            du="$(jq -r .duration <<< "$s" | grep -v null | sed 's/^PT//')"
            ge="$(jq -r '.genre[]' <<< "$s" | awk '{print}' ORS=' ')"
            r="$(jq -r .aggregateRating.ratingValue <<< "$s" | grep -v null)"
            rc="$(jq -r .aggregateRating.ratingCount <<< "$s" | grep -v null)"

            if [[ -n "${r:-}" ]]; then
                printf "%b\n" "\033[33m[$r ($rc)]\033[0m \033[32m$t\033[0m - $dp \033[34m$du\033[0m $ge"
            else
                printf "%b\n" "\033[32m$t\033[0m - $dp \033[34m$du\033[0m $ge"
            fi
        fi
    done <<< $(curl -sS "https://v2.sg.media-imdb.com/suggestion/${tt:0:1}/${tt// /_}.json" | jq -r '.d[].id')
}

#/ ip2int: convert IP address to an integer
ip2int() {
    local st nd rd th
    st="$(awk -F '.' '{print $1}' <<< "$1")"
    nd="$(awk -F '.' '{print $2}' <<< "$1")"
    rd="$(awk -F '.' '{print $3}' <<< "$1")"
    th="$(awk -F '.' '{print $4}' <<< "$1")"
    echo "$((st*256*256*256+nd*256*256+rd*256+th))"
}

#/ ipinfo <ip>: show IP info
ipinfo () {
    curl -sS "https://ipinfo.io/widget/demo/$1" -H 'Referer: https://ipinfo.io' --compressed | jq '.data | del(.abuse)'
}

#/ islegitsite <domain_url>: check site is legit or not
islegitsite() {
    local r="$(curl -sS -L "https://www.islegitsite.com/check/$1")"

    printf '%b\n' "\033[32mWOT Rating\033[0m"
    htmlq -t '.container div:nth-child(4) .panel-body .label' <<< "$r" | sedremovespace

    printf '%b\n' "\033[32mWebsite Blacklist\033[0m"
    htmlq -t '.container div:nth-child(5) .panel-body table td' <<< "$r" \
        | sedremovespace \
        | grep -v 'More Information'

    printf '%b\n' "\033[32mDomain Creation\033[0m"
    htmlq -t '.container div:nth-child(7) .panel-body .font-bold' <<< "$r" | sedremovespace

    printf '%b\n' "\033[32mWebsite Popularity\033[0m"
    htmlq -t '.container div:nth-child(9) .panel-body .font-bold' <<< "$r" | sedremovespace
    htmlq -t '.container div:nth-child(9) .panel-body strong' <<< "$r" | sedremovespace
    htmlq -t '.container div:nth-child(9) .panel-body a' -a href <<< "$r" | sedremovespace
}

#/ jsonpath: command to print each path/value pair
jsonpath() { jq -r 'paths(scalars) as $p | "." + ([([$p[] | tostring] | join(".")), (getpath($p) | tojson)] | join(": "))' }

#/ json2yaml: convert JSON to YAML
json2yaml () {
    python -c 'import sys, yaml, json; print(yaml.dump(json.loads(sys.stdin.read())))'
}

# less: use vim as pager to replace less
less () {
    local conf highlight
    conf="set guioptions=aiMr | set nomodifiable | set laststatus=0 | nmap q :q!<CR> | color iceberg | set norelativenumber"
    highlight="hi Normal guibg=NONE | hi EndOfBuffer guibg=NONE | hi clear LineNr | hi clear SignColumn | hi LineNr guifg=#555555"
    if [[ -f "${1:-}" ]]; then
        vim -c "$conf" -c "$highlight" $1
    else
        vim -c "$conf" -c "$highlight" -c "set syntax=${1:-md}" <<< "$(< /dev/stdin)" -
    fi
}

#/ leet <text>: convert text to leetspeak
leet () {
    local t="$@"
    t="${t//a/4}"
    t="${t//e/3}"
    t="${t//i/1}"
    t="${t//o/0}"
    t="${t//s/5}"
    t="${t//t/7}"
    echo "$t"
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
    o=$(curl -sS "https://www.lyrics.com/lyrics/${1// /%20}" | sed -E 's/\r$/---/g' | htmlq '.sec-lyric')
    m=$(grep -c '.sec-lyric' <<< "$o")
    [[ "$m" -gt 11 ]] && m=10

    for (( i = 0; i < m; i++ )); do
        s=$(htmlq 'div.sec-lyric:nth-child('"$((i+1))"')' <<< "$o")
        t=$(htmlq -t '.lyric-meta-title' <<< "$s" | sedremovespace)
        a=$(htmlq -t '.lyric-meta-album-artist' <<< "$s" | sedremovespace)
        [[ "$a" == "" ]] && a=$(htmlq -t '.lyric-meta-artists' <<< "$s" | sedremovespace)
        l=$(htmlq -t '.lyric-body' <<< "$s" | sedremovespace | awk '{printf "%s ",$0}' | sed -E 's/---/\n/g' | sedremovespace)
        printf '\n%b\n' "\033[32m$t\033[0m - $a\n$l" | sed -E "s/\&#39;/\'/g"
    done
}

#/ mangaupdate <manga_name>: search mangaupdate
mangaupdate () {
    local o m t y r
    o=$(curl -sS "https://www.mangaupdates.com/series.html?search=${1// /+}&display=list&type=manga&perpage=20" | htmlq 'div.p-2:nth-child(2) > div:nth-child(2)')
    m=$(grep -c 'py-1' <<< "$o")
    for (( i = 0; i < m; i++ )); do
        t=$(htmlq -t 'div.py-1:nth-child('"$((i*4+6))"')' <<< "$o" | sedremovespace)
        y=$(htmlq -t 'div.col-1:nth-child('"$((i*4+8))"')' <<< "$o" | sedremovespace)
        r=$(htmlq -t 'div.col-1:nth-child('"$((i*4+9))"')' <<< "$o" | sedremovespace)
        [[ ! "$r" ]] && r="n/a "
        printf '%b\n' "\033[33m[$r]\033[0m $y $t"
    done
}

#/ metacritic <game_title>: search metacritic game rating
metacritic() {
    local i=0 s len d t r p
    while true; do
        s="$(curl -sS -A g "https://www.metacritic.com/search/game/${1// /%20}/results?page=$i")"
        len="$(grep -c 'li class="result' <<< "$s")"
        if [[ "$len" -ge 1 ]]; then
            for (( j = 1; j <= len; j++ )); do
                d="$(htmlq ".search_results li:nth-child($j)" <<< "$s")"
                t="$(htmlq -t '.product_title' <<< "$d" | sedremovespace)"
                r="$(htmlq -t '.metascore_w' <<< "$d" | sedremovespace)"
                p="$(htmlq -t '.main_stats p' <<< "$d" | sedremovespace | awk '{printf "%s ",$0}')"
                printf "%b\n" "\033[33m[$r]\033[0m \033[32m$t\033[0m - $p"
            done
        fi
        [[ "$len" -lt 10 ]] && break
        ((i++))
    done
}

#/ myanimelist <anime_name>: search anime info
myanimelist () { printf "$(curl -sS "https://myanimelist.net/search/prefix.json?type=all&keyword=${1// /%20}&v=1" | jq -r '.categories[] | select (.type == "anime" or .type == "manga") | .items[] | "\\033[33m[\(.payload.score)]\\033[0m+\(.name)++\(.payload.media_type)+\(.payload.aired)+\(.payload.published)"' | sed -E 's/\+null//' | column -t -s '+')" }

#/ myip: show my ip address
myip () {
    local o ip loc
    o="$(curl -sS 'https://duckduckgo.com/?q=my%20ip')"
    ip="$(grep -oE "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" <<< "$o")"
    loc="$(htmlq -t script <<< "$o" | rg DDG.duckbar | sed 's/.*">//' | sed 's/<\/a.*//')"
    echo "$ip - $loc"
}

#/ mytimezone: show my timezone
mytimezone () { curl -s 'https://ipapi.co/timezone' }

#/ mytraceroute: returns a traceroute from my servers to my ip address
mytraceroute () { curl 'icanhaztraceroute.com' }

#/ mytrafficproxied : determine if my taffic is proxied or not
mytrafficproxied () { curl 'icanhazproxy.com' }

#/ opencritic <game>:show OpenCritic game scores
opencritic ()  {
    local t d len item n l r
    t="${1// /%20}"
    t="${t//:/%3A}"
    t="${t//\'/%27}"
    d="$(curl -sS "https://api.opencritic.com/api/meta/search?criteria=${t}" -H 'Origin: https://opencritic.com' --compressed)"
    len="$(jq 'length' <<< "$d")"
    for (( i = 0; i < len; i++ )); do
        item="$(jq -r ".[$i]" <<< "$d")"
        if [[ "$(jq -r .relation <<< "$item")" == "game" ]]; then
            n="$(jq -r '.name' <<< "$item")"
            l="$(jq -r '"\(.id)/\(.name)"' <<< "$item" \
                | sed 's/[^[:alnum:] \/]//g' \
                | tr -s '[:space:]' \
                | sed 's/ /-/g' \
                | tr '[:upper:]' '[:lower:]')"
            r="$(curl -sS "https://opencritic.com/game/$l" \
                | htmlq -t '.inner-orb' \
                | awk '{$1=$1};1' \
                | sed '/$/N;s/\n/\//')"
            printf "%b\n" "\033[33m[$r]\033[0m \033[32m$n\033[0m"
        fi
    done
}

#/ outline <url>: generate outline link
outline () {
    local u=$(curl -sS "https://api.outline.com/v3/parse_article?source_url=$1" -H 'Referer: https://outline.com/' | jq -r '.data.short_code')
    xdg-open "https://outline.com/$u"
}

#/ plug: mount plugged-in device(s)
plug () {
    local dl d
    dl="$(lsblk | grep -v sda | grep sd | grep -v /media | sed 's/└─//;s/├─//' | awk '{print $1}')"
    while read -r d; do
        if grep -coE "[0-9]+" <<< "$d" > /dev/null \
            || ! grep -c "${d}1" <<< "$dl" > /dev/null; then
                udisksctl mount -b "/dev/${d}"
        fi
    done <<< "$dl"
}

#/ port <port_number>: port lookup
port () { curl -sS 'https://www.portcheckers.com/port-number-assignment' --data-raw port="$1" | grep '<tr><td>' | sed -E 's/<[\/]?t[rd]>/ /g' | sedremovespace }

#/ qotd: quote of the day
qotd () { curl -s 'https://favqs.com/api/qotd' | jq -r '.quote | "\"\(.body)\" - \(.author)"'; echo }

#/ randompwd <length>: generate random password, min. length is 4
randompwd () {
    local n p
    while true; do
        [[ "${1:-}" -gt 4 ]] && n="$1" || n=4
        p="$(tr -dc 'a-zA-Z0-9!@#$%^&*()[]{}_=+-?.,:;' < /dev/random | head -c"$n")"
        if grep -Ec '[0-9]' <<< "$p" > /dev/null && \
           grep -Ec '[a-z]' <<< "$p" > /dev/null && \
           grep -Ec '[A-Z]' <<< "$p" > /dev/null && \
           grep -Ec '[^a-zA-Z0-9]' <<< "$p" > /dev/null; then
            echo -n "$p"
            break
        fi
    done
}

#/ randomuser: generate random user
randomuser () { curl -sS 'https://randomuser.me/api/' | jq }

#/ reversegeocode <lat,log>: reverse geocoding
reversegeocode () {
    curl -sS "http://www.mapquestapi.com/geocoding/v1/reverse?key=${MAP_QUEST_KEY}&location=${1// /%20}" | jq -r '.results[0].locations[0] | "\(.street), \(.postalCode) \(.adminArea5)"'
}

#/ rawtojpg <raw_file>: convert raw image to jpg
rawtojpg () { mkdir -p jpg; for i in *.CR2; do dcraw -c "$i" | cjpeg -quality 100 -optimize -progressive > ./jpg/$(echo $(basename "$i" ".CR2").jpg); done }

#/ rottentomatoes <title>: rottentomatoes search
rottentomatoes () {
    local d sId aId o r
    d="$(curl -sS https://www.rottentomatoes.com/ | grep thirdParty)"
    sId="$(sed 's/.*sId":"//;s/"}.*//' <<< "$d")"
    aId="$(sed 's/.*aId":"//;s/",".*//' <<< "$d")"
    o="$(curl -sS "https://79frdp12pn-dsn.algolia.net/1/indexes/*/queries?x-algolia-api-key=${sId}&x-algolia-application-id=${aId}" --data-raw '{"requests":[{"indexName":"content_rt","query":"'"$1"'","params":"filters=isEmsSearchable%20%3D%201&hitsPerPage=10"}]}' --compressed)"
    r=$(jq -r '.results[0].hits[] | "\\033[33m[\(.rottenTomatoes.criticsScore) \(.rottenTomatoes.audienceScore)]\\033[0m+++\(.type)+++\(.releaseYear)+++\(.title)"' <<< "$o")"\n"
    printf '%b' "$r" | column -t -s '+++'
}

#/ savepage <url>: save webpage to one single HTML file
savepage() { monolith "$1" > $(date +%s).html }

#/ screenshot: take screenshot
screenshot () { import -quiet -pause 2 $(date +%s).jpg }

#/ shodan <IP>: search IP on shodan.io
shodan () {
    local o d di de
    o="$(curl -sS "https://api.shodan.io/shodan/host/${1}?key=${SHODAN_API_KEY}")"
    [[ "$o" =~ "title>404 Not Found<" ]] && return
    d=$(printf "%b|" "\033[1m\033[33mHostnames:\033[0m\033[0m")
    d+=$(jq -r '.hostnames[]' <<< "$o" | awk -v ORS=", " '1')
    d+=$(printf "\n%b|" "\033[1m\033[33mDomains:\033[0m\033[0m")
    d+=$(jq -r '.domains[]' <<< "$o" | awk -v ORS=", " '1')
    d+=$(printf "\n%b|" "\033[1m\033[33mCountry:\033[0m\033[0m")
    d+=$(jq -r '"\(.country_name) (\(.country_code))"' <<< "$o")
    d+=$(printf "\n%b|" "\033[1m\033[33mCity:\033[0m\033[0m")
    d+=$(jq -r '.city' <<< "$o")
    d+=$(printf "\n%b|" "\033[1m\033[33mOrganization:\033[0m\033[0m")
    d+=$(jq -r '.org' <<< "$o")
    d+=$(printf "\n%b|" "\033[1m\033[33mISP:\033[0m\033[0m")
    d+=$(jq -r '.isp' <<< "$o")
    d+=$(printf "\n%b|" "\033[1m\033[33mASN:\033[0m\033[0m")
    d+=$(jq -r '.data[0].asn' <<< "$o")
    d+=$(printf "\n%b|" "\033[1m\033[33mSSL Cert Issuer:\033[0m\033[0m")
    d+=$(jq -r '.data[] | select(.port==443) | .ssl.cert.issuer | to_entries|map("\(.key)=\(.value|tostring)")|.[]' <<< "$o" | awk -v ORS=", " '1')
    d+=$(printf "\n%b|" "\033[1m\033[33mSSL Cert Subject:\033[0m\033[0m")
    d+=$(jq -r '.data[] | select(.port==443) | .ssl.cert.subject | to_entries|map("\(.key)=\(.value|tostring)")|.[]' <<< "$o" | awk -v ORS=", " '1')
    d+=$(printf "\n%b|" "\033[1m\033[33mSSL Cert Validity:\033[0m\033[0m")
    di="$(jq -r '.data[] | select(.port==443) | .ssl.cert.issued' <<< "$o")"
    de="$(jq -r '.data[] | select(.port==443) | .ssl.cert.expires' <<< "$o")"
    d+="${di:0:4}-${di:4:2}-${di:6:2} ${di:8:2}:${di:10:2}:${di:12:2} - ${de:0:4}-${de:4:2}-${de:6:2} ${de:8:2}:${de:10:2}:${de:12:2}"
    echo "$d" | column -t -s '|' | sed 's/, $//'
}

#/ showpath: show PATH
showpath () { awk -v RS=: '{print}' <<<$PATH }

#/ snykadvisor <name> <source>: get pacakge info from Snyk Advisor
snykadvisor () {
    # $1: package name
    # $2: npm, python or docker
    local n="${1:-}"
    local s="${2:-npm}"
    local d len
    d="$(curl -sS "https://snyk.io/advisor/search?source=${s}&q=${n}" | htmlq '.package')"
    len="$(htmlq '.package' <<< "$d" | grep -c 'class="package"')"
    for (( i = 1; i <= len; i++ )); do
        printf '%b. \033[1m%b \033[34m%b\033[0m\033[0m\n' \
            "$i" \
            "$(htmlq -t '.package:nth-child('"$i"') .package-title' <<< "$d" | sedremovespace)" \
            "$(htmlq -t '.package:nth-child('"$i"') .number' <<< "$d" | sedremovespace | sed -E 's/ \/ 100//')"
        printf '\033[1;30m[%b] %b\033[0m\n' \
            "$(htmlq -t '.package:nth-child('"$i"') .package-history' <<< "$d" | sedremovespace | sed 'N;s/\n/ /')" \
            "$(htmlq -t '.package:nth-child('"$i"') .package-details p' <<< "$d" | sedremovespace)"
        printf '%b\n\n' "$(htmlq -t '.package:nth-child('"$i"') a' -a href <<< "$d")"
    done
}

#/ timezone <city>: show timezone of a city
timezone() {
    local data
    data="$(curl -sSL "https://time.is/${1// /_}" -H 'Accept-Language: en-US,en' -A 'c')"
    htmlq -t '#clock0_bg' <<< "$data"
    htmlq -t '#dd' <<< "$data"
    htmlq -t '.keypoints' <<< "$data"
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


#/ uplung: unmount device(s)
unplug () {
    local dl d
    dl="$(lsblk | grep -v sda | grep sd | grep /media | sed 's/└─//;s/├─//' | awk '{print $1}')"
    while read -r d; do
        udisksctl unmount -b "/dev/${d}"
    done <<< "$dl"
}

#/ unshorten <url>: reveal shortened URL
unshorten() { curl -sSL -I "$1" | grep 'Location: ' | awk -F ': ' '{print $2}' }

#/ v <img> [viu params]: display image in terminal
v () { [[ "$(echo $1 | tr '[a-z]' '[A-Z]')" =~ (CR2|DNG)$ ]] && dcraw -c -w "$1" | cjpeg | viu "${@:2}" || viu "$@" }

#/ what3words: get random 3 words
what3words () {
    local latitude longitude
    latitude="$(python3 -c 'import random;print("{:.6f}".format(random.uniform(-90, 90)))')"
    longitude="$(python3 -c 'import random;print("{:.6f}".format(random.uniform(-180, 180)))')"
    curl -sS "https://mapapi.what3words.com/api/convert-to-3wa?coordinates=$latitude%2C$longitude&language=en&format=json" | jq -r .words
}

#/ weather <location>: get weather info
weather () { curl "wttr.in/$1" }

#/ weatherhourly <location>: get hourly weather info
weatherhourly () {
    local host k d cn h t f p
    host="www.accuweather.com"
    u="$(curl -sS "https://$host/en/search-locations?query=${1// /+}" -A 'accu' --compressed | htmlq -t '.locations-list a' -a href | grep web-api | head -1)"
    k="$(curl -sSL "https://$host/$u" -A accu --compressed -D - | grep -i location: | awk '{print $2}' | sed 's/.*forecast\///' | sed 's/\?.*//')"
    d="$(curl -sSL "https://$host/en/us/${1// /-}/$k/hourly-weather-forecast/$k" -A 'accu' --compressed | htmlq '.hourly-wrapper')"
    cn="$(grep -c 'hourly-card-top' <<< "$d")"
    for ((day = 1; day < 3; day++ )) do
        [[ "$day" -eq 1 ]] && echo "TODAY"
        [[ "$day" -eq 2 ]] && echo -e "\nTOMORROW"
        d="$(curl -sSL "https://$host/en/us/${1// /-}/$k/hourly-weather-forecast/${k}?day=${day}" -A 'accu' --compressed | htmlq '.hourly-wrapper')"
        cn="$(grep -c 'hourly-card-top' <<< "$d")"
        for ((i = 1; i <= cn; i++ )) do
            h="$(htmlq -t ".hour:nth-child($i) .date div" <<< "$d")"
            f="$(htmlq -wp -t ".hour:nth-child($i) .real-feel__text" <<< "$d" | tr '\n' ' ' | sed 's/.*®//' | awk '{$1=$1};1')"
            t="$(htmlq -t ".hour:nth-child($i) .temp" <<< "$d")"
            p="$(htmlq -t ".hour:nth-child($i) .precip" <<< "$d" | tr '\n' ' ' | awk '{$1=$1};1')"
            if [[ -n ${h:-} ]]; then
                printf '%*s: %s(%s) %s\n' 5 "$h" "$t" "$f" "$p"
            fi
        done
    done
}

#/ whatcms: show cms used by website $1
whatcms () { curl -sS "https://whatcms.org/APIEndpoint/Detect?key=$(cat $WHATCMS_KEY_FILE | shuf | tail -1)&url=$1" | jq . }

#/ whohosts: show host info of website $1
whohosts () { curl -sS "https://www.who-hosts-this.com/APIEndpoint/Detect?key=$(cat $WHATCMS_KEY_FILE | shuf | tail -1)&url=$1" | jq . }

#/ writeup <keyword>: search bug bounty writeups
writeup () {
    local u
    u="$(curl -sS 'https://www.bugbountyhunting.com/' | grep 'script.js' | sed -E 's/.*https:/https:/' | sed -E "s/'><\/script>//")"
    curl -sS "$u" | grep 'var data =' | sed -E 's/var data =//' | jq . | rg -A 1 'title".*'"$1"
}

#/ yaml2json: convert YAML to JSON
yaml2json () {
    python -c 'import sys, yaml, json; print(json.dumps(yaml.safe_load(sys.stdin.read()), indent=2, sort_keys=False))'
}

#/ yd <url>: download youtube video, max. resolution 1080
yd () { yt-dlp -f 'bestvideo[height<=?1080][fps<=?30]+bestaudio/best' $(sed -E 's/.*www.youtube/https:\/\/www.youtube/' <<< "$1" | sed -E 's/%2F/\//g;s/%3F/\?/g;s/%3D/\=/g' | sed -E 's/\&list=.*//') }

#/ yd720 <url>: download youtube video, max. resolution 720
yd720 () { yt-dlp -f 'bestvideo[height<=?720][fps<=?30]+bestaudio/best' $(sed -E 's/.*www.youtube/https:\/\/www.youtube/' <<< "$1" | sed -E 's/%2F/\//g;s/%3F/\?/g;s/%3D/\=/g' | sed -E 's/\&list=.*//') }

#/ yda <url>: download youtube audio
yda () { yt-dlp -x $(sed -E 's/.*www.youtube/https:\/\/www.youtube/' <<< "$1" | sed -E 's/%2F/\//g;s/%3F/\?/g;s/%3D/\=/g' | sed -E 's/\&list=.*//') }

#/ yds <url>: download youtube with subtitle
yds () { yt-dlp --write-auto-sub --convert-subs=srt --sub-lang en,en-US $(sed -E 's/.*www.youtube/https:\/\/www.youtube/' <<< "$1" | sed -E 's/%2F/\//g;s/%3F/\?/g;s/%3D/\=/g' | sed -E 's/\&list=.*//') }

#/ youtuberss <url>: get YouTube RSS QR code
youtuberss () { url=$(curl -s "$1" | htmlq 'link' | grep RSS | sed -e 's/^.*href="//' | sed -e 's/">.*$//'); echo "$url"; qr "$url"}

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
setopt hist_ignore_space

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
# Plugins
#------------------------------
source "${HOME}/.zsh/fzf-tab/fzf-tab.plugin.zsh"
source "${HOME}/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh"
source "${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "${HOME}/.zsh/fzf/completion.zsh"
source "${HOME}/.zsh/fzf/key-bindings.zsh"
source "${HOME}/.zsh/fzf/command-snippet.zsh"
source "${HOME}/.zsh/z.lua.plugin.zsh"
source "${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"

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

#-----------------------------
# Syntax Highlight Styles
#-----------------------------

ZSH_HIGHLIGHT_STYLES[path]='none'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=#5F87D7,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#87D787'
ZSH_HIGHLIGHT_STYLES[command]='fg=#87D787'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#889FC2'
ZSH_HIGHLIGHT_STYLES[function]='fg=#889FC2'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=#889FC2'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#9E95C4,bold'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]='fg=#889FC2'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]='fg=#889FC2'
ZSH_HIGHLIGHT_STYLES[globbing]='none'
ZSH_HIGHLIGHT_STYLES[assign]='fg=#D9A67E'
ZSH_HIGHLIGHT_STYLES[comment]='fg=#474A59'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#93B7C1'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#93B7C1'
setopt INTERACTIVE_COMMENTS

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
disable r

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

#------------------------------
# Prompt
#------------------------------
eval "$(starship init zsh)"
