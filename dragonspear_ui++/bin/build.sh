#!/usr/bin/env sh

[ -x "$(command -v lua)" ] || exit 42

cd 'dragonspear_ui++/menu'
lua '../bin/build.lua' "$1.lua" '../build/ui.menu'
