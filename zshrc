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
alias lg='f() { logsave -a "${HOME}/stdout/$(date +%s)" zsh -c "source ~/.zshrc; $1" }; f'
alias mcd='f(){ mkdir -p "$1" && cd "$1" }; f'
alias md='rich -m $1'
alias mpv='f(){ mpv "$1" &> /dev/null & }; f'
alias nv='$EDITOR -c ":NV"'
alias ping='prettyping --nolegend'
alias please='sudo $(fc -ln -1)'
alias po='f() { sleep "$1" && systemctl poweroff }; f'
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
alias watchout='f() { fswatch -r -0 --event=Updated "$1" 2>/dev/null | xargs -0 -n 1 zsh -c "$2; date +%H:%M:%S"}; f'
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
alias lw='f() { ls "$1" | wc -l }; f'
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
    eva -f 2 "$calc"
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

#/ antonym <word>: search for antonym of a word
antonym() { curl -sS https://www.thesaurus.com/browse/$1| htmlq -t 'script' | grep INITIAL_STATE | sed -E 's/.*INITIAL_STATE = //;s/;$//' | sed -E 's/:undefined,/:null,/g'| jq -r '.searchData.tunaApiData.posTabs[] | .definition as $definition | .pos as $pos | .antonyms | sort_by (.term) | .[] | select((.similarity | tonumber)<-51) | "\($pos) \($definition):: \(.term)"' | awk -F"::" '{if ($1==prev) printf ",%s", $2; else printf "\n\n%s\n %s", $1, $2; prev=$1} END {print "\n"}' }

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
    curl -sS "https://www.brainyquote.com/search_results?q=${1// /+}" | htmlq -t -w '.clearfix' | sedremovespace | sed -E "s/\&#39;/\'/g" | awk 'NR % 2 {print} !(NR % 2) {printf "- %s\n\n",$0 }'
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
cht () { curl "cht.sh/$1/${2// /%20}" }

#/ cpu <keyword>: find CPU info from PassMark: Name; Mark; Rank; Value; Price
cpu () {
    local out
    out="Name;;Mark;;Rank;;Value;;Price"$'\n'
    out+="$(curl -sS 'https://www.cpubenchmark.net/cpu_list.php' | grep 'cpu_lookup' | sed 's/<\/td/;;<\/td/g' | htmlq -t | grep -i "$1")"
    column -t -s ';;' <<< "$out"
}

#/ currency <from_currency> <to_currency> <number>: fetch currency exchange rate
currency () { curl -sS "https://www.xe.com/currencyconverter/convert/?Amount=$3&From=${1:u}&To=${2:u}" |  htmlq -t 'p[class*="BigRate"]' }

#/ cvss <vector>: calculate cvss3.1 score
cvss() {
    local v="${1:-}" ip
    if [[ -z "${v:-}" ]]; then
        read ip\?"AV:NALP AC:LH PR:NLH UI:NR S:UC C:NLH I:NLH A:NLH: "
        v="CVSS:3.1/AV:${ip:0:1}/AC:${ip:1:1}/PR:${ip:2:1}/UI:${ip:3:1}/S:${ip:4:1}/C:${ip:5:1}/I:${ip:6:1}/A:${ip:7:1}"
        v="${v:u}"
    fi
    echo "$v"
    "$(command -v chromium)" --headless --disable-gpu --dump-dom "https://www.first.org/cvss/calculator/3.1#$v" 2>/dev/null \
    | htmlq -t '#baseMetricGroup .scoreRating span' \
    | awk '{printf "%s ", $0;}'
    echo
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

#/ cvetrends [24hrs|7days]: show CVE trends in 24hrs or 7days
cvetrends() { curl -sS "https://cvetrends.com/api/cves/${1:-24hrs}" | jq -r '.data[] | "\(.cve)\n\(.description)\n"' }

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

#/ dekudeals <game>: show game prices from DekuDeals
dekudeals () {
    local d l r len o="" p
    d="$(curl -sS "https://www.dekudeals.com/autocomplete?term=${1// /%20}" | jq -r '.[] | "[\(.url)] \(.name)"')"
    l="$(fzf -1 -0 <<< "$d" \
        | awk -F']' '{print $1}' \
        | sed -E 's/^\[//')"
    r="$(curl -sS "https://www.dekudeals.com/${l}")"
    len="$(htmlq '.item-price-table tr' <<< "$r" | grep -c "</tr>")"
    for i in $(seq 1 "$len"); do
        p="$(htmlq -t ".item-price-table tr:nth-child($i)" <<< "$r" \
            | sedremovespace \
            | tr '\n' ' ')"
        [[ "$p" =~ ^Digital* || "$p" =~ ^Physical* ]] && o+="\n$p" || o+=" $p"
    done
    echo -e "$o\n---" | sed -E '/^[[:space:]]*$/d'
    len="$(htmlq -t '#price-history table tr' <<< "$r" | grep -c "</tr>")"
    for i in $(seq 1 "$len"); do
        htmlq -t "#price-history table tr:nth-child($i)" <<< "$r" \
            | sedremovespace \
            | sed '/$/N;s/\n/ /'
    done
}

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
    m=$(grep -o sc-bZQynM <<< "$o" | wc -l)
    for (( i = 0; i < m; i++ )); do
        s=$(htmlq '.sc-bZQynM:nth-child('$((i+1))')' <<< "$o")
        if [[ "$s" ]]; then
            t=$(htmlq -t '.title-text' <<< "$s" | sedremovespace | sed -E "s/\&#39;/\'/g")
            r=$(htmlq -t '.rating_nums' <<< "$s" | sedremovespace)
            rc=$(htmlq -t '.pl' <<< "$s" | sedremovespace)
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
getlinks () { curl -sS "$1" | htmlq 'a, link, base, area' -a  href | sedremovespace | sort -u }

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

#/ h1 <keyword>: search disclosed report from h1
h1() {
    curl -sS -X POST https://hackerone.com/graphql -H 'content-type: application/json' -d '{"query":"query HacktivityPageQuery($querystring: String, $orderBy: HacktivityItemOrderInput, $secureOrderBy: FiltersHacktivityItemFilterOrder, $where: FiltersHacktivityItemFilterInput, $count: Int, $cursor: String) {\n  hacktivity_items(first: $count, after: $cursor, query: $querystring, order_by: $orderBy, secure_order_by: $secureOrderBy, where: $where) {\n    total_count\n    ...HacktivityList\n  }\n}\n\nfragment HacktivityList on HacktivityItemConnection {\n  edges {\n    node {\n      ... on HacktivityItemInterface {\n        ...HacktivityItem\n      }\n    }\n  }\n}\n\nfragment HacktivityItem on HacktivityItemUnion {\n\n  ... on Disclosed {\n    ...HacktivityItemDisclosed\n  }\n  ... on HackerPublished {\n    ...HacktivityItemHackerPublished\n  }\n}\n\nfragment HacktivityItemDisclosed on Disclosed {\n  report {\n    title\n    url\n  substate\n  }\n  latest_disclosable_activity_at\n  severity_rating\n}\n\nfragment HacktivityItemHackerPublished on HackerPublished {\n  report {\n    title\n    url\n  substate\n  }\n  latest_disclosable_activity_at\n  severity_rating\n}","variables":{"querystring":"'"$1"'","where":{"report":{"disclosed_at":{"_is_null":false}}},"orderBy":{"field":"popular","direction":"DESC"},"secureOrderBy":null,"count":100},"operationName":"HacktivityPageQuery"}' | jq -r '.data.hacktivity_items.edges[].node.report'
}

#/ help <keyword>: list functions
help () { grep "^#/" "${HOME}/.zshrc" | cut -c4- | rg -i "${@:-}" }

#/ holiday <country_code> <year>: list of public holidays in country $1 in year $2
holiday () { [[ -z $2 ]] && y=$(date "+%Y") || y="$2"; curl -s "https://date.nager.at/Api/v2/PublicHolidays/$y/$1" | jq -r '.[] | "\(.date) \(.localName) - \(.name)"' }

#/ howlongtobeat <name>: search how long to beat a game
howlongtobeat () {
    local d
    d="$(curl -sS 'https://howlongtobeat.com/api/search' -A 'x' \
        -H 'content-type: application/json' \
        -H 'referer: https://howlongtobeat.com/' \
        --data-raw '{"searchType":"games","searchTerms":["'"${1// /\",\"}"'"],"searchPage":1,"size":20,"searchOptions":{"games":{"userId":0,"platform":"","sortCategory":"popular","rangeCategory":"main","rangeTime":{"min":0,"max":0},"gameplay":{"perspective":"","flow":"","genre":""},"modifier":""},"users":{"sortCategory":"postcount"},"filter":"","sort":0,"randomizer":0}}' \
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
            s="$(curl -sS "https://www.imdb.com/title/$i/" | htmlq -t 'script' | grep '"@context')"
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

#/ magespace <prompt_text> <times>: generate image using mage.space
magespace () {
    local loop t d id seed ourl eurl url
    loop="${2:-1}"
    t="$(curl -sS "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${MAGE_SPACE_KEY}" --data-raw '{"returnSecureToken":true}' | jq -r '.idToken')"
    for (( i = 0; i < loop; i++ )); do
        echo "Generating image $((i+1))..."
        d="$(curl -sS 'https://api.mage.space/api/v2/images/generate' -H "authorization: Bearer $t" -H 'content-type: application/json' --data-raw '{"prompt":"'"$1"'","aspect_ratio":1.5,"num_inference_steps":150,"guidance_scale":12.5}')"
        id="$(jq -r '.results[0].id' <<< "$d" 2> /dev/null)"
        seed="$(jq -r '.results[0].metadata.seed' <<< "$d" 2> /dev/null)"
        ourl="$(jq -r '.results[0].image_url' <<< "$d" 2> /dev/null)"

        if [[ -z ${ourl:-} ]]; then
            echo "[ERROR] Cannot generate image"
        else
            eurl="$(curl -sS 'https://api.mage.space/api/v2/images/enhance' -H "authorization: Bearer $t" -H 'content-type: application/json' --data-raw '{"id":"'"$id"'"}' | jq -r '.results[0].enhanced_image_url')"

            if [[ -z ${eurl:-} ]]; then
                echo "[ERROR] Cannot enhance image $id"
                url="$ourl"
            else
                url="$eurl"
            fi
            echo "Downloading ${id}-${seed}.png"
            curl -sS "$url" -o "${id}-${seed}.png"
        fi
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
myip () { curl -4 'ifconfig.co/json'; curl -6 'ifconfig.co' }

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

#/ playstoresearch <term>: search apps in Play Store by term
playstoresearch () { curl -sS -H "X-Apptweak-Key: $APPTWEAK_KEY" "https://api.apptweak.com/android/searches.json?language=en&term=$1" | jq }

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

#/ quodb <quote>: movie quote search
quodb () { printf "$(curl -sS "http://api.quodb.com/search/${1// /%20}?page=1&titles_per_page=50&phrases_per_title=1" | jq -r '.docs[] | "\\033[32m\(.phrase)\\033[0m - \(.title) \(.year)"')" }

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

#/ synonym <word>: search for synonym of a word
synonym() { curl -sS https://www.thesaurus.com/browse/$1| htmlq -t 'script' | grep INITIAL_STATE | sed -E 's/.*INITIAL_STATE = //;s/;$//' | sed -E 's/:undefined,/:null,/g' | jq -r '.searchData.tunaApiData.posTabs[] | .definition as $definition | .pos as $pos | .synonyms | sort_by (.term) | .[] | select((.similarity | tonumber)>49) | "\($pos) \($definition):: \(.term)"' | awk -F"::" '{if ($1==prev) printf ",%s", $2; else printf "\n\n%s\n %s", $1, $2; prev=$1} END {print "\n"}' }

#/ timezone <city>: show timezone of a city
timezone() {
    local data
    data="$(curl -sSL "https://time.is/${1// /_}" -H 'Accept-Language: en-US,en' -A 'c')"
    htmlq -t '#clock0_bg' <<< "$data"
    htmlq -t '#dd' <<< "$data"
    htmlq -t '.keypoints' <<< "$data"
}

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

#/ vrt <keyword>: Bugcrowd’s Vulnerability Rating Taxonomy search
vrt () {
    local d nl n np cl cn cp ccl ccn ccp vf
    vf="${HOME}/.vrt.json"
    vrtdownload "https://raw.githubusercontent.com/bugcrowd/vulnerability-rating-taxonomy/master/vulnerability-rating-taxonomy.json" "7" "$vf"

    d="$(jq -r 'paths(scalars) as $p | "." + ([([$p[] | tostring] | join(".")), (getpath($p) | tojson)] | join(": "))' < "$vf" | grep -v '.id:' | grep -v '.type:')"
    nl="$(tail -1 <<< "$d" | awk -F '.' '{print $3}')"
    for (( i = 0; i <= nl; i++ )); do
        np="$(grep ".content.${i}.priority" <<< "$d" | sed 's/.*: /: P/')"
        n="$(grep ".content.${i}.name" <<< "$d" | sed 's/.*: "//' | sed 's/"$//')${np}"
        cl="$(grep ".content.${i}.children." <<< "$d" | tail -1 | awk -F '.' '{print $5}')"
        if [[ -n "${cl:-}" ]]; then
            for (( j = 0; j <= cl; j++ )); do
                cp="$(grep ".content.${i}.children.${j}.priority" <<< "$d" | sed 's/.*: /: P/')"
                cn="$n > $(grep ".content.${i}.children.${j}.name" <<< "$d" | sed 's/.*: "//' | sed 's/"$//')${cp}"
                ccl="$(grep ".content.${i}.children.${j}.children." <<< "$d" | tail -1 | awk -F '.' '{print $7}')"
                if [[ -n "${ccl:-}" ]]; then
                    for (( jj = 0; jj <= ccl; jj++ )); do
                        ccp="$(grep ".content.${i}.children.${j}.children.${jj}.priority" <<< "$d" | sed 's/.*: /: P/')"
                        ccn="$cn > $(grep ".content.${i}.children.${j}.children.${jj}.name" <<< "$d" | sed 's/.*: "//' | sed 's/"$//')${ccp}"
                        echo "$ccn" | rg -i "$1"
                    done
                else
                    echo "$cn" | rg -i "$1"
                fi
            done
        else
            echo "$n" | rg -i "$1"
        fi
    done
}

#/ vrt2cvss <keyword>: convert Bugcrowd’s VRT to CVSS score
vrt2cvss () {
    local id vf cf
    vf="${HOME}/.vrt.json"
    vrtdownload "https://raw.githubusercontent.com/bugcrowd/vulnerability-rating-taxonomy/master/vulnerability-rating-taxonomy.json" "7" "$vf"
    cf="${HOME}/.vrt2cvss.json"
    vrtdownload "https://raw.githubusercontent.com/bugcrowd/vulnerability-rating-taxonomy/master/mappings/cvss_v3/cvss_v3.json" "7" "$cf"

    while read -r id; do
        echo "---"
        grep -i "$id" -A 1 < "$cf" | sedremovespace | sed -E 's/,$//;s/"$//;s/.*": "//'
    done <<< "$(grep -i 'name": .*'"$1" -B 1 < "$vf" | grep '"id":' | sed -E 's/,$//;s/"$//;s/.*": "//')"
}

#/ vrt2cwe <keyword>: show Bugcrowd’s VRT CWE mappings
vrt2cwe () {
    local id vf d
    vf="${HOME}/.cwe.json"
    vrtdownload "https://raw.githubusercontent.com/bugcrowd/vulnerability-rating-taxonomy/master/mappings/cwe/cwe.json" "7" "$vf"
    d="$(jq -r 'paths(scalars) as $p | "." + ([([$p[] | tostring] | join(".")), (getpath($p) | tojson)] | join(": "))' < "$vf")"

    while read -r l; do
        id="$(grep "$l" <<< "$d" | awk '{print $1}')"
        cwe="$(grep "${id//id/cwe.0}" <<< "$d" | awk '{print $2}')"
        echo "$l $cwe" | grep "$1"
    done <<< "$(grep ".id:" <<< "$d" | awk '{print $2}')"
}

#/ vrtadvice <keyword>: show Bugcrowd’s VRT redediation advice
vrtadvice () {
    local id vf cf d prefix
    vf="${HOME}/.vrt.json"
    vrtdownload "https://raw.githubusercontent.com/bugcrowd/vulnerability-rating-taxonomy/master/vulnerability-rating-taxonomy.json" "7" "$vf"
    cf="${HOME}/.vrtadvice.json"
    vrtdownload "https://raw.githubusercontent.com/bugcrowd/vulnerability-rating-taxonomy/master/mappings/remediation_advice/remediation_advice.json" "7" "$cf"
    d="$(jq -r 'paths(scalars) as $p | "." + ([([$p[] | tostring] | join(".")), (getpath($p) | tojson)] | join(": "))' "$cf")"
    while read -r id; do
        if [[ -n "${id:-}" ]]; then
            prefix="$(grep 'id: "' <<< "$d" | grep "\"${id}\"" | sed 's/id: ".*$//')"
            if [[ -n "${prefix:-}" ]]; then
                echo -e "--$id--\n$(grep "${prefix}remediation_advice" <<< "$d" | sed 's/.*.remediation_advice: //')"
                grep "${prefix}references" <<< "$d" | sed 's/.*.references.*: //'
            fi
        fi
    done <<< "$(grep -i 'name": .*'"$1" -B 1 < "$vf" | grep '"id":' | sed -E 's/,$//;s/"$//;s/.*": "//' | sort -u)"
}

# Download VRT JSON files
vrtdownload () {
    # $1: URL
    # $2: expiration day
    # $3: output file
    local dl=0 fu no
    if [[ ! -s "$3" ]]; then
        dl=1
    else
        fu=$(date -d "$(date -r "$3") +$2 day" +%s)
        no=$(date +%s)
        [[ "$no" -gt "$fu" ]] && dl=1
    fi

    if [[ "$dl" == "1" ]]; then
        curl -sS "$1" > "$3"
    fi
}

#/ weather <location>: get weather info
weather () { curl "wttr.in/$1" }

#/ weatherhourly <location>: get hourly weather info
weatherhourly () {
    local l k d cn h t p
    l="${1// /+}"
    k="$(curl -sS "https://www.accuweather.com/en/search-locations?query=$l" -A 'accu' --compressed | htmlq -t '.locations-list a' -a href | grep web-api | head -1 | sed 's/.*key=//;s/\&target.*//')"

    d="$(curl -sSL "https://www.accuweather.com/en/us/${1// /-}/$k/hourly-weather-forecast/$k" -A 'accu' --compressed | htmlq '.hourly-wrapper')"
    cn="$(grep -c 'id="hourlyCard' <<< "$d")"

    for (( day = 1; day < 3; day++ )); do
        [[ "$day" -eq 1 ]] && echo "TODAY"
        [[ "$day" -eq 2 ]] && echo -e "\nTOMORROW"
        d="$(curl -sSL "https://www.accuweather.com/en/us/${1// /-}/$k/hourly-weather-forecast/${k}?day=${day}" -A 'accu' --compressed | htmlq '.hourly-wrapper')"
        cn="$(grep -c 'id="hourlyCard' <<< "$d")"
        for (( i = 0; i < cn; i++ )); do
            h="$(htmlq -t "#hourlyCard${i} .date" <<< "$d")"
            t="$(htmlq -t "#hourlyCard${i} .temp" <<< "$d")"
            p="$(htmlq -t -w "#hourlyCard${i} .precip" <<< "$d")"
            echo "$h: $t $(tr -d '\n' <<< "$p")"
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
source "${HOME}/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh"
source "${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "${HOME}/.zsh/fzf/completion.zsh"
source "${HOME}/.zsh/fzf/key-bindings.zsh"
source "${HOME}/.zsh/fzf/command-snippet.zsh"
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
