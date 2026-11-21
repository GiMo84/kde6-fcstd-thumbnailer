#!/usr/bin/env bash
set -euo pipefail

project_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
data_home=${XDG_DATA_HOME:-"$HOME/.local/share"}
bin_dir="$HOME/.local/bin"
thumbnailer_dir="$data_home/thumbnailers"

for cmd in unzip file; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        printf 'Missing dependency: %s\n' "$cmd" >&2
        printf 'On Ubuntu, install it with: sudo apt install %s\n' \
            "$([[ "$cmd" == "unzip" ]] && echo unzip || echo file)" >&2
        exit 1
    fi
done

install -d "$bin_dir" "$thumbnailer_dir"
install -m 0755 "$project_dir/bin/fcstd-thumbnailer" \
    "$bin_dir/fcstd-thumbnailer"
install -m 0644 "$project_dir/thumbnailers/fcstd.thumbnailer" \
    "$thumbnailer_dir/fcstd.thumbnailer"

printf 'Installed FreeCAD thumbnailer.\n'
printf '  Script:      %s/fcstd-thumbnailer\n' "$bin_dir"
printf '  Registration: %s/fcstd.thumbnailer\n' "$thumbnailer_dir"

if command -v kbuildsycoca6 >/dev/null 2>&1; then
    kbuildsycoca6 --noincremental
fi

printf '\nRestart Dolphin, then test with a folder containing .FCStd files.\n'
printf 'If thumbnails were cached previously, remove the affected cached entries\n'
printf 'or temporarily clear ~/.cache/thumbnails to force regeneration.\n'
