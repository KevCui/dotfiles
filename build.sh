#!/bin/zsh

HOME=$(pwd)
OUTPUT=${HOME}/output

# Check commands exist
if [ ! "$(command -v yq)" ]; then
    echo "Please install yq first"
    exit 1
fi

if [ ! "$(command -v rg)" ]; then
    echo "Please install ripgrep first"
    exit 1
fi

# Check config yaml file
if [ ! -f "$1" ]; then
    echo "Config file $1 doesn't exist!"
    echo "./build.sh <config.yaml>"
    exit 1
fi

# Create directory for output
mkdir -p "$OUTPUT"

for filename in $(yq -r '. | to_entries[]'.key "$1"); do
    echo "Generating ${filename}..."
    if [ ! -f "$filename" ]; then
        echo "$filename doesn't exist!"
        break
    fi

    if [[ "$filename" = *"/"* ]]; then
        mkdir -p "$OUTPUT/$(dirname $filename)"
    fi

    cmd="sed"
    for key in $(yq -r '.["'$filename'"] | to_entries[]'.key "$1"); do
        var=$(yq -r '.["'$filename'"]["'$key'"]' "$1")
        echo "  Key: $key, Value: $var"
        cmd="$cmd -e 's/%$key%/$var/g'"
    done
    cmd="$cmd $HOME/$filename > $OUTPUT/$filename"
    eval "$cmd"
done

# Show unreplaced variables
rg '%\w\w+%' $OUTPUT 2> /dev/null
