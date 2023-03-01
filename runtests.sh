#!/usr/bin/env bash

set -euo pipefail

run() {
    lua main.lua "$@"
}

run parse < test/input/forge1.txt > test/output/forge1.lua
run parse < test/input/forge2.txt > test/output/forge2.lua
run parse < test/input/hardhat1.txt > test/output/hardhat1.lua
run parse < test/input/hardhat2.txt > test/output/hardhat2.lua
run diff test/output/forge1.lua test/output/forge2.lua > test/diff/forge.lua
run diff test/output/hardhat1.lua test/output/hardhat2.lua > test/diff/hardhat.lua
run printdiff < test/diff/forge.lua > test/diff/forge.md
run printdiff < test/diff/hardhat.lua > test/diff/hardhat.md
