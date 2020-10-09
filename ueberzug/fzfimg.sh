#!/usr/bin/env bash
# This is just an example how ueberzug can be used with fzf.
# Copyright (C) 2019  Nico Baeurer

# Forked from https://github.com/seebye/ueberzug/blob/master/examples/fzfimg.sh
# Modified by Kevin Cui

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
readonly BASH_BINARY="$(which bash)"
readonly REDRAW_COMMAND="toggle-preview+toggle-preview"
readonly REDRAW_KEY="µ"
readonly FD="$(command -v fd)"
readonly IMG_EXTENSION_LIST="$(dirname "$(realpath "$0")")/extension.list"
declare -r -x DEFAULT_PREVIEW_POSITION="right"
declare -r -x UEBERZUG_FIFO="$(mktemp --dry-run --suffix "fzf-$$-ueberzug")"
declare -r -x PREVIEW_ID="preview"


function is_option_key [[ "${@}" =~ ^(\-.*|\+.*) ]]
function is_key_value [[ "${@}" == *=* ]]


function map_options {
    local -n options="${1}"
    local -n options_map="${2}"

    for ((i=0; i < ${#options[@]}; i++)); do
        local key="${options[$i]}" next_key="${options[$((i + 1))]:---}"
        local value=true
        is_option_key "${key}" || \
            continue
        if is_key_value "${key}"; then
            <<<"${key}" \
                IFS='=' read key value
        elif ! is_option_key "${next_key}"; then
            value="${next_key}"
        fi
        options_map["${key}"]="${value}"
    done
}


function parse_options {
    declare -g -a script_options=("${@}")
    declare -g -A mapped_options
    map_options script_options mapped_options
    declare -g -r -x PREVIEW_POSITION="${mapped_options[--preview-window]%%:[^:]*}"
}


function start_ueberzug {
    mkfifo "${UEBERZUG_FIFO}"
    <"${UEBERZUG_FIFO}" \
        ueberzug layer --parser bash --silent &
    # prevent EOF
    3>"${UEBERZUG_FIFO}" \
        exec
}

function finalise {
    exec 3>&-
    rm "${UEBERZUG_FIFO}" &>/dev/null
    pkill -9 ueberzug &>/dev/null
}


function calculate_position {
    # TODO costs: creating processes > reading files
    #      so.. maybe we should store the terminal size in a temporary file
    #      on receiving SIGWINCH
    #      (in this case we will also need to use perl or something else
    #      as bash won't execute traps if a command is running)
    < <(</dev/tty stty size) \
        read TERMINAL_LINES TERMINAL_COLUMNS

    case "${PREVIEW_POSITION:-${DEFAULT_PREVIEW_POSITION}}" in
        left|up|top)
            X=1
            Y=1
            ;;
        right)
            X=$((TERMINAL_COLUMNS - COLUMNS - 2))
            Y=1
            ;;
        down|bottom)
            X=1
            Y=$((TERMINAL_LINES - LINES - 1))
            ;;
    esac
}


function draw_preview {
    calculate_position

    >"${UEBERZUG_FIFO}" declare -A -p cmd=( \
        [action]=add [identifier]="${PREVIEW_ID}" \
        [x]="${X}" [y]="${Y}" \
        [width]="${COLUMNS}" [height]="${LINES}" \
        [scaler]=fit_contain
        [path]="${@}")
        # add [synchronously_draw]=True if you want to see each change
}


function print_on_winch {
    # print "$@" to stdin on receiving SIGWINCH
    # use exec as we will only kill direct childs on exiting,
    # also the additional bash process isn't needed
    </dev/tty \
        exec perl -e '
            while (1) {
                local $SIG{WINCH} = sub {
                    ioctl(STDIN, &TIOCSTI, $_) for split "", join " ", @ARGV;
                };
                sleep;
            }' \
            "${@}" &
}


function filter_input_source {
    local extension
    if [[ -s "$IMG_EXTENSION_LIST" ]]; then
        extension="-e $(sed ':a; N; $!ba; s/\n/ -e /g' "$IMG_EXTENSION_LIST")"
    else
        extension="-e jpg"
    fi
    "$BASH_BINARY" -c "$FD -d 1 $extension -X ls -t"
}


if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    trap finalise EXIT
    parse_options "${@}"
    # print the redraw key twice as there's a run condition we can't circumvent
    # (we can't know the time fzf finished redrawing it's layout)
    print_on_winch "${REDRAW_KEY}${REDRAW_KEY}"
    start_ueberzug

    export -f draw_preview calculate_position
    SHELL="${BASH_BINARY}" \
        fzf -0 -1 -m --cycle \
            --preview "draw_preview {}" \
            --preview-window "${DEFAULT_PREVIEW_POSITION}" \
            --bind "tab:down,btab:up,ctrl-j:up,ctrl-k:down,change:top,alt-space:toggle,ctrl-a:select-all,ctrl-u:deselect-all" \
            --bind "${REDRAW_KEY}:${REDRAW_COMMAND}" \
            --bind "enter:abort+execute(exiftool {1})" \
            "${@}" <<< $(filter_input_source)
fi
