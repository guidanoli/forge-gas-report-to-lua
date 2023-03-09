#!/usr/bin/env bash

# Quickly parse, diff and print gas reports
# Usage: ./quickdiff.sh <a> <b>

set -euo pipefail

if [ $# -ge 2 ]
then
    apath=`readlink -f "$1"`
    bpath=`readlink -f "$2"`
    shift 2
else
    echo "Usage: $0 <a> <b>" >&2
    exit 1
fi

cd "${BASH_SOURCE%/*}"

a=`mktemp`
b=`mktemp`

lua main.lua parse < "$apath" > "$a"
lua main.lua parse < "$bpath" > "$b"
lua main.lua diff "$a" "$b" | lua main.lua printdiff

rm -f "$a" "$b"
