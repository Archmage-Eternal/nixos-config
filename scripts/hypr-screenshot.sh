#!/usr/bin/env bash

set -euo pipefail

screenshot_dir="${XDG_PICTURES_DIR:-$HOME/Pictures}/Screenshots"
mkdir -p "$screenshot_dir"

timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
output_file="$screenshot_dir/Screenshot_${timestamp}.png"

notify() {
    notify-send "$@"
}

usage() {
    cat <<EOF
Usage: hypr-screenshot <copy-area|save-area|save-screen>
EOF
}

case "${1:-}" in
    copy-area)
        geometry=$(slurp -d)
        [[ -n "$geometry" ]] || exit 0
        grim -g "$geometry" - | wl-copy
        notify "Screenshot copied" "Selected area copied to clipboard."
        ;;
    save-area)
        geometry=$(slurp -d)
        [[ -n "$geometry" ]] || exit 0
        grim -g "$geometry" "$output_file"
        notify "Screenshot saved" "$output_file"
        ;;
    save-screen)
        grim "$output_file"
        notify "Screenshot saved" "$output_file"
        ;;
    *)
        usage
        exit 1
        ;;
esac