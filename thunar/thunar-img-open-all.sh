#!/usr/bin/env bash

for i in "$@"; do
    viewnior "$i" &
done
