#!/usr/bin/env bash

set -euo pipefail

run() {
    echo "$@" >&2
    lua main.lua "$@"
}

run parse --format=forge --input=test/input/forge1.txt --output=test/output/forge1.lua
run parse --format=forge --input=test/input/forge2.txt --output=test/output/forge2.lua
run parse --format=hardhat --input=test/input/hardhat1.txt --output=test/output/hardhat1.lua
run parse --format=hardhat --input=test/input/hardhat2.txt --output=test/output/hardhat2.lua
run diff test/output/forge1.lua test/output/forge2.lua --output=test/diff/forge.lua
run diff test/output/hardhat1.lua test/output/hardhat2.lua --output=test/diff/hardhat.lua
