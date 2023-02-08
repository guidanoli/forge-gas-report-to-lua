#!/usr/bin/env bash

set -euo pipefail

run() {
    echo "$@" >&2
    lua main.lua "$@"
}

run parse --format=forge --input=test/input/forge.txt --output=test/output/forge.lua
run parse --format=hardhat --input=test/input/hardhat.txt --output=test/output/hardhat.lua
