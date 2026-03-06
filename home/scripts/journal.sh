#!/usr/bin/env bash

NOTEBOOK="journal"

# Helper function to get today's filename
get_today_filename() {
    echo "$(date +%F).md"
}

# Helper function to get filename for date offset (e.g., -1 for yesterday, +2 for day after tomorrow)
get_offset_filename() {
    local offset=$1
    echo "$(date -d "$offset days" +%F).md"
}

# Helper function to get current time in HH:MM format
get_current_time() {
    date +%H:%M
}

# Check if a note exists in the notebook (suppress all output)
_nb_exists() {
    nb show "$NOTEBOOK:$1" > /dev/null 2>&1
}

# Append a line to today's entry.
# Adds a leading blank line if this is the first entry after the heading.
_append_to_today() {
    local text="$1"
    local filename
    filename=$(get_today_filename)
    local line_count
    line_count=$(nb show "$NOTEBOOK:$filename" --print --no-color | wc -l)
    if [[ $line_count -le 1 ]]; then
        printf '\n%s\n' "$text" | nb edit "$NOTEBOOK:$filename"
    else
        echo "$text" | nb edit "$NOTEBOOK:$filename"
    fi
}

# fzf picker over all journal entries (or pre-filtered by query if args given).
# Preview pane shows the full entry content via bat.
# Returns a normalised notebook:id selector on stdout.
_fzf_journal_pick() {
    local prompt="journal"
    local raw

    if [[ $# -gt 0 ]]; then
        prompt="$*"
        raw=$(nb search "$NOTEBOOK:" "$*" --list --no-color 2>/dev/null)
    else
        raw=$(nb list "$NOTEBOOK:" --no-color 2>/dev/null)
    fi

    local candidates
    candidates=$(echo "$raw" | grep -E '^\[[^]]+\]')

    if [[ -z "$candidates" ]]; then
        echo "No journal entries found${1:+ for \"$*\"}." >&2
        return 1
    fi

    local selected
    selected=$(echo "$candidates" \
        | fzf --ansi \
              --prompt="$prompt > " \
              --preview="nb show \"journal:\$(echo {} | grep -oP '(?<=\[)[^]]+(?=\])' | grep -oP '[0-9]+$')\" --print --no-color 2>/dev/null | bat --language=md --style=plain --color=always" \
              --preview-window=right:60%:wrap \
              --height=80%)

    [[ -z "$selected" ]] && return 1

    local raw_id
    raw_id=$(echo "$selected" | grep -oP '(?<=\[)[^]]+(?=\])')
    [[ "$raw_id" != *:* ]] && raw_id="$NOTEBOOK:$raw_id"
    echo "$raw_id"
}

# Helper function to ensure today's note exists
ensure_note_exists() {
    local filename
    filename=$(get_today_filename)
    local today
    today=$(date +%F)
    if ! _nb_exists "$filename"; then
        nb new "$NOTEBOOK:$filename" --content "$(echo -e "# $today\n")" > /dev/null 2>&1
    fi
}

# Start a tracked activity (record start time only)
cmd_start() {
    ensure_note_exists
    local current_time
    current_time=$(get_current_time)
    _append_to_today "- $current_time - [ongoing]"
    echo "Started at $current_time"
}

# End the ongoing activity and add description (optional)
cmd_end() {
    ensure_note_exists
    local filename=$(get_today_filename)
    local end_time=$(get_current_time)
    local description="$*"

    # Get the content of today's note
    local content=$(nb show "$NOTEBOOK:$filename" --print --no-color)

    # Find last line number with [ongoing]
    local lineno=$(echo "$content" | awk '/\[ongoing\]/{n=NR} END{print n}')
    if [[ -z "$lineno" || "$lineno" == "0" ]]; then
        echo "Error: No ongoing activity found"
        return 1
    fi

    # Extract start time from that line (expects format: - HH:MM - [ongoing])
    local start_time=$(echo "$content" | sed -n "${lineno}p" | sed -E 's/^- ([0-9]{2}:[0-9]{2}) - .*$/\1/')

    if [[ -z "$start_time" ]]; then
        start_time="?"
    fi

    # Build replacement line
    local new_line
    if [[ -n "$description" ]]; then
        new_line="- $start_time - $end_time : $description"
    else
        new_line="- $start_time - $end_time"
    fi

    # Replace only that specific line and write back
    local updated_content=$(echo "$content" | awk -v ln="$lineno" -v nl="$new_line" 'NR==ln{print nl; next} {print}')
    echo "$updated_content" | nb edit "$NOTEBOOK:$filename" --overwrite
    echo "Ended activity at $end_time"
    if [[ -n "$description" ]]; then
        echo "Description added: $description"
    fi
}

# Log a one-off event
cmd_log() {
    local description="$*"
    if [[ -z "$description" ]]; then
        echo "Error: Event description required"
        echo "Usage: j log \"Event description\""
        return 1
    fi
    ensure_note_exists
    local current_time
    current_time=$(get_current_time)
    _append_to_today "- $current_time : $description"
    echo "Logged: $description"
}

# Add a subpoint to the last entry
cmd_sub() {
    local description="$*"
    if [[ -z "$description" ]]; then
        echo "Error: Subpoint description required"
        echo "Usage: j sub \"Additional details\""
        return 1
    fi
    ensure_note_exists
    _append_to_today "    - $description"
    echo "Added subpoint: $description"
}

# Open today's note in editor
cmd_add() {
    ensure_note_exists
    local filename=$(get_today_filename)
    nb edit "$NOTEBOOK:$filename"
}

# Browse all entries or pre-filter by query, pick with fzf, open in editor
cmd_open() {
    local nb_id
    nb_id=$(_fzf_journal_pick "$@") || return 1
    nb edit "$nb_id"
}

# Open an entry from N days ago (default: 1 = yesterday)
cmd_previous() {
    local raw="${1:-1}"

    # Normalize: convert +N or N to -N (we only navigate to past entries)
    if [[ "$raw" =~ ^\+[0-9]+$ ]]; then
        raw="-${raw#+}"
    elif [[ "$raw" =~ ^[0-9]+$ ]]; then
        raw="-$raw"
    fi

    if [[ ! "$raw" =~ ^-[0-9]+$ ]]; then
        echo "Error: expected a number, e.g. j prev 2" >&2
        return 1
    fi

    local filename target_date
    filename=$(get_offset_filename "$raw")
    target_date=$(date -d "$raw days" +%F)

    if _nb_exists "$filename"; then
        nb edit "$NOTEBOOK:$filename"
    else
        echo "No entry found for $target_date"
        return 1
    fi
}

# Show usage/help
get_usage() {
    cat <<EOF
Usage: j {start|end|log|sub|add|open|prev|help}

Commands:
    start (s)                     Start a tracked activity.
    end (e)    [description]      End the ongoing activity with optional description.
    log (l)    <description>      Log a one-off timestamped event.
    sub (b)    <description>      Add a subpoint to the last entry.
    add (a)                       Open today's note in editor. (default)
    open (o)   [query]            Browse all entries or pre-filter by query (fzf → editor).
    prev (p)   [N | -N | +N]      Open entry from N days ago (default: 1 = yesterday).
    help (h)                      Show this help.
EOF
}

# Main command dispatcher
case "${1:-}" in
    start|s)
        shift; cmd_start "$@"
        ;;
    end|e)
        shift; cmd_end "$@"
        ;;
    log|l)
        shift; cmd_log "$@"
        ;;
    sub|b)
        shift; cmd_sub "$@"
        ;;
    add|a)
        shift; cmd_add
        ;;
    open|o)
        shift; cmd_open "$@"
        ;;
    prev|p)
        shift; cmd_previous "$@"
        ;;
    -[0-9]*|+[0-9]*|[0-9]*)
        cmd_previous "$1"
        ;;
    help|h|-h|--help)
        get_usage
        ;;
    "")
        cmd_add
        ;;
    *)
        echo "Unknown command: $1" >&2
        get_usage
        exit 1
        ;;
esac
