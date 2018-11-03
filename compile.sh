#!/bin/bash
URL="https://github.com/shacknetisp/crawl-rc"

cd "$(dirname "$0")"
test -e compile.sh || exit 1

ROOT="$(pwd)"

TMP="/tmp/crc_$RANDOM"
touch "$TMP"

echo "#-#-# Automatically Compiled Units"
echo "#-#-# Generated from $URL"
echo "#-#-# Units Begin:"

cd "$ROOT/include"

for dir in *; do
    test -d "$dir" || continue;

    for file in "$dir"/*; do
        test -e "$file" || continue;

        dext=${file##*.}
        ext=${dext#.}

        export CRC_FILE="$file"
        export CRC_NAME="$(basename "$file" .$ext)"

        echo
        echo "#-#-# Unit: $CRC_NAME ($CRC_FILE)"

        test -e "$ROOT/handlers/$ext" && {
            bash "$ROOT/handlers/$ext"
        } || echo "No handler for extension: $ext" > /dev/stderr
    done
done

cd ..

rm "$TMP"
