#!/bin/sh

set -euo pipefail

mkdir -p ${HOME}/._z

curl -fLo ${HOME}/._z/bash https://raw.githubusercontent.com/rupa/z/master/z.sh
curl -fLo ${HOME}/._z/fish https://raw.githubusercontent.com/sjl/z-fish/master/z.fish
