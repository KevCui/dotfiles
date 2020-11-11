#!/usr/bin/env bash
source "$(dirname "$(realpath "$0")")/devicons.sh"

if [ -p /dev/stdin ]; then
    while IFS= read -r line; do
        if [[ -d "$line" ]]; then
            echo "$i_folder" "$line"
        else
            filename=$(basename "$line")
            extension=${filename##*.}
            [[ -z "${extension:-}" || "$extension" == "$filename" \
            || "$extension" =~ "-" || "$extension" =~ "#" ]] \
                && extension="default"

            iconname="i_${extension,,}"
            [[ -z "${!iconname}" ]] && iconname="i_default"
            echo "${!iconname} $line"
        fi
    done
fi
