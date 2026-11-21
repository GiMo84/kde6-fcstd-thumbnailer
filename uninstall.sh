#!/usr/bin/env bash
set -euo pipefail

data_home=${XDG_DATA_HOME:-"$HOME/.local/share"}
rm -f -- "$HOME/.local/bin/fcstd-thumbnailer"
rm -f -- "$data_home/thumbnailers/fcstd.thumbnailer"

if command -v kbuildsycoca6 >/dev/null 2>&1; then
    kbuildsycoca6 --noincremental
fi

printf 'Uninstalled the FreeCAD thumbnailer.\n'
