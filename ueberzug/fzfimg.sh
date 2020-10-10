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

set_var() {
    readonly BASH_BINARY="$(which bash)"
    readonly REDRAW_COMMAND="toggle-preview+toggle-preview"
    readonly REDRAW_KEY="µ"
    readonly FD="$(command -v fd)"
    readonly IMG_EXTENSION_LIST="$(dirname "$(realpath "$0")")/extension.list"
    DEFAULT_PREVIEW_POSITION="right"
    UEBERZUG_FIFO="$(mktemp --dry-run --suffix "-fzf-$$-ueberzug")"
}

start_ueberzug() {
    mkfifo "${UEBERZUG_FIFO}"
    ueberzug layer --parser bash --silent <"${UEBERZUG_FIFO}" &
    exec 3> "${UEBERZUG_FIFO}"
}

finalise() {
    exec 3>&-
    rm -f "${UEBERZUG_FIFO}" &>/dev/null
}

calculate_position() {
    < <(</dev/tty stty size) \
        read -r TERMINAL_LINES TERMINAL_COLUMNS

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

draw_preview() {
    local cmd
    calculate_position
    declare -A -p cmd=([action]=add [identifier]="fzf-preview" \
        [x]="${X}" [y]="${Y}" \
        [width]="${COLUMNS}" [height]="${LINES}" \
        [scaler]=fit_contain \
        [path]="${*}") > "${UEBERZUG_FIFO}"
}

filter_input_source() {
    local extension=""
    [[ -s "$IMG_EXTENSION_LIST" ]] &&  \
        extension="-e $(sed ':a; N; $!ba; s/\n/ -e /g' "$IMG_EXTENSION_LIST")"
    "$BASH_BINARY" -c "$FD -d 1 $extension -X ls -t"
}

main() {
    set_var
    start_ueberzug

    export -f draw_preview calculate_position
    export UEBERZUG_FIFO DEFAULT_PREVIEW_POSITION
    if [[ "$#" -eq 0 ]]; then
        filelist="$(filter_input_source)"
    else
        filelist="$(sed -E 's/ /\n/g' <<< "$*")"
    fi
    SHELL="${BASH_BINARY}" fzf -0 -m --cycle \
        --preview "draw_preview {}" \
        --preview-window "${DEFAULT_PREVIEW_POSITION}" \
        --bind "tab:down,btab:up,ctrl-j:up,ctrl-k:down,change:top,alt-space:toggle,ctrl-a:select-all,ctrl-u:deselect-all" \
        --bind "${REDRAW_KEY}:${REDRAW_COMMAND}" \
        --bind "enter:abort+execute(exiftool {1})" <<< "$filelist"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    trap finalise EXIT
    main "$@"
fi
