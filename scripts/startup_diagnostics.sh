#!/usr/bin/env bash

set -u

timestamp=$(date +%Y%m%d-%H%M%S)
output_dir=${1:-"startup-diag-$timestamp"}

mkdir -p "$output_dir"

run_capture() {
    local name="$1"
    shift

    {
        echo "$ $*"
        echo
        if "$@"; then
            :
        elif command -v sudo > /dev/null 2>&1 && sudo -n true > /dev/null 2>&1; then
            echo
            echo "Retrying with sudo -n"
            echo
            sudo -n "$@"
        else
            echo
            echo "Command failed, and passwordless sudo is unavailable."
            return 1
        fi
    } > "$output_dir/$name.txt" 2>&1
}

run_shell_capture() {
    local name="$1"
    local command="$2"

    {
        echo "$ $command"
        echo
        if bash -lc "$command"; then
            :
        elif command -v sudo > /dev/null 2>&1 && sudo -n true > /dev/null 2>&1; then
            echo
            echo "Retrying with sudo -n bash -lc"
            echo
            sudo -n bash -lc "$command"
        else
            echo
            echo "Command failed, and passwordless sudo is unavailable."
            return 1
        fi
    } > "$output_dir/$name.txt" 2>&1
}

cat > "$output_dir/README.txt" <<EOF
Startup diagnostics bundle

Created: $(date --iso-8601=seconds)
Host: $(hostname)

Key files:
- systemd-analyze-time.txt
- systemd-analyze-blame.txt
- systemd-analyze-critical-chain.txt
- journal-warning-error.txt
- journal-startup-filtered.txt
- journal-greetd.txt
- journal-user-session.txt
- wayland-sessions-list.txt
- wayland-sessions-details.txt
- boot.svg

Suggested next review order:
1. systemd-analyze-time.txt
2. systemd-analyze-blame.txt
3. systemd-analyze-critical-chain.txt
4. journal-startup-filtered.txt
5. wayland session files for duplicate entries
EOF

run_capture hostname hostnamectl
run_capture uname uname -a
run_capture uptime uptime
run_capture bootctl-status bootctl status

run_capture systemd-analyze-time systemd-analyze time
run_capture systemd-analyze-blame systemd-analyze blame
run_capture systemd-analyze-critical-chain systemd-analyze critical-chain

if ! systemd-analyze plot > "$output_dir/boot.svg" 2> "$output_dir/boot-plot.stderr"; then
    : > "$output_dir/boot.svg"
fi

run_capture systemctl-failed systemctl --failed
run_capture systemctl-list-jobs systemctl list-jobs
run_capture journal-warning-error journalctl -b -p warning..err
run_shell_capture journal-startup-filtered "journalctl -b | rg -i 'timed out|timeout|failed|slow|module|firmware|niri|greetd|tpm|crypt|luks|initrd'"
run_capture journal-greetd journalctl -b -u greetd
run_shell_capture journal-user-session "journalctl --user -b | rg -i 'niri|dms|portal|dbus|xdg|uwsm'"

run_shell_capture wayland-sessions-list "ls -l /run/current-system/sw/share/wayland-sessions"
run_shell_capture wayland-sessions-links "readlink -f /run/current-system/sw/share/wayland-sessions/*"
run_shell_capture wayland-sessions-details 'for f in /run/current-system/sw/share/wayland-sessions/*; do echo "== $f =="; sed -n "1,160p" "$f"; echo; done'

cat <<EOF
Diagnostics written to: $output_dir
Review README.txt first.
EOF