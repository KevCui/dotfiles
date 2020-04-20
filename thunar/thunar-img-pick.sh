#!/usr/bin/env bash

for i in "$@"; do
    dir="$(dirname "$i")/pick"
    mkdir -p "$dir"
    mv "$i" "$dir"
done
