#!/usr/bin/env bash

set -euo pipefail

state_dir="${XDG_RUNTIME_DIR:-/run/user/$UID}/hypr-record"
pid_file="$state_dir/wf-recorder.pid"
file_file="$state_dir/output-path"
record_dir="${XDG_VIDEOS_DIR:-$HOME/Videos}/Recordings"

mkdir -p "$state_dir" "$record_dir"

notify() {
    notify-send "$@"
}

stop_recording() {
    if [[ ! -f "$pid_file" ]]; then
        return 1
    fi

    pid=$(cat "$pid_file")
    if kill -0 "$pid" 2> /dev/null; then
        kill -INT "$pid"
        wait "$pid" 2> /dev/null || true
    fi

    output_file=""
    if [[ -f "$file_file" ]]; then
        output_file=$(cat "$file_file")
    fi

    rm -f "$pid_file" "$file_file"

    if [[ -n "$output_file" ]]; then
        notify "Recording saved" "$output_file"
    else
        notify "Recording stopped"
    fi
}

start_recording() {
    local mode="$1"
    local timestamp output_file geometry

    timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
    output_file="$record_dir/Recording_${timestamp}.mp4"

    case "$mode" in
        area)
            geometry=$(slurp)
            [[ -n "$geometry" ]] || exit 0
            wf-recorder -g "$geometry" -f "$output_file" > /dev/null 2>&1 &
            ;;
        screen)
            wf-recorder -f "$output_file" > /dev/null 2>&1 &
            ;;
        *)
            echo "Usage: hypr-record <toggle-area|toggle-screen|stop>" >&2
            exit 1
            ;;
    esac

    echo $! > "$pid_file"
    echo "$output_file" > "$file_file"
    notify "Recording started" "$output_file"
}

case "${1:-}" in
    toggle-area)
        if [[ -f "$pid_file" ]] && kill -0 "$(cat "$pid_file")" 2> /dev/null; then
            stop_recording
        else
            start_recording area
        fi
        ;;
    toggle-screen)
        if [[ -f "$pid_file" ]] && kill -0 "$(cat "$pid_file")" 2> /dev/null; then
            stop_recording
        else
            start_recording screen
        fi
        ;;
    stop)
        stop_recording
        ;;
    *)
        echo "Usage: hypr-record <toggle-area|toggle-screen|stop>" >&2
        exit 1
        ;;
esac