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

# Helper function to ensure today's note exists
ensure_note_exists() {
    local filename=$(get_today_filename)
    local today=$(date +%F)
    
    if ! nb show "$NOTEBOOK:$filename" > /dev/null 2>&1; then
        nb new "$NOTEBOOK:$filename" --content "$(echo -e "# $today\n")" > /dev/null 2>&1
    fi
}

# Start a tracked activity (record start time only)
cmd_start() {
    ensure_note_exists
    local filename=$(get_today_filename)
    local current_time=$(get_current_time)

    # Check if this is the first entry (file only has heading)
    local content=$(nb show "$NOTEBOOK:$filename" --print --no-color)
    local line_count=$(echo "$content" | wc -l)

    if [[ $line_count -eq 1 ]]; then
        # First entry, add blank line before it
        local entry="\n- $current_time - [ongoing]"
        echo -e "$entry" | nb edit "$NOTEBOOK:$filename"
    else
        # Not first entry, no blank line
        local entry="- $current_time - [ongoing]"
        echo "$entry" | nb edit "$NOTEBOOK:$filename"
    fi
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
    local filename=$(get_today_filename)
    local current_time=$(get_current_time)
    
    # Check if this is the first entry (file only has heading)
    local content=$(nb show "$NOTEBOOK:$filename" --print --no-color)
    local line_count=$(echo "$content" | wc -l)
    
    if [[ $line_count -eq 1 ]]; then
        # First entry, add blank line before it
        local entry="\n- $current_time : $description"
        echo -e "$entry" | nb edit "$NOTEBOOK:$filename"
    else
        # Not first entry, no blank line
        local entry="- $current_time : $description"
        echo "$entry" | nb edit "$NOTEBOOK:$filename"
    fi
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
    local filename=$(get_today_filename)
    local entry="    - $description"
    
    # Append to the note
    echo "$entry" | nb edit "$NOTEBOOK:$filename"
    echo "Added subpoint: $description"
}

# Open today's note in editor
cmd_add() {
    ensure_note_exists
    local filename=$(get_today_filename)
    nb edit "$NOTEBOOK:$filename"
}

# Show a specific date's entry
cmd_show() {
    local date_arg="$1"
    local filename
    
    if [[ -z "$date_arg" ]]; then
        filename=$(get_today_filename)
    else
        filename="$date_arg.md"
    fi
    
    if nb show "$NOTEBOOK:$filename" > /dev/null 2>&1; then
        nb show "$NOTEBOOK:$filename" --print
    else
        echo "No entry found for $filename"
        return 1
    fi
}

# (removed) recent command

# Search journal entries
cmd_search() {
    local query="$*"
    if [[ -z "$query" ]]; then
        echo "Error: Search query required"
        echo "Usage: j search <query>"
        return 1
    fi
    
    nb search "$NOTEBOOK:" "$query"
}

# Open yesterday's entry
cmd_yesterday() {
    local filename=$(get_offset_filename -1)
    if nb show "$NOTEBOOK:$filename" > /dev/null 2>&1; then
        nb edit "$NOTEBOOK:$filename"
    else
        echo "No entry found for yesterday"
        return 1
    fi
}

# Handle relative day navigation — only view past entries (N days ago)
# Accepts: N, -N, +N — all treated as N days ago (no future creation)
cmd_relative() {
    local raw=$1
    if [[ -z "$raw" ]]; then
        echo "Error: relative requires an offset, e.g. 1 or -1"
        return 1
    fi

    # Normalize: convert +N or N to -N (we only view past entries)
    if [[ "$raw" =~ ^\+[0-9]+$ ]]; then
        raw="-${raw#+}"
    elif [[ "$raw" =~ ^[0-9]+$ ]]; then
        raw="-$raw"
    fi

    # ensure we have a negative offset
    if [[ ! "$raw" =~ ^-[0-9]+$ ]]; then
        echo "Error: relative only supports past offsets (e.g. 1 or -1)." 
        return 1
    fi

    local filename=$(get_offset_filename "$raw")
    local target_date=$(date -d "$raw days" +%F)

    # Only open existing past entries; do not create new files for past or future
    if nb show "$NOTEBOOK:$filename" > /dev/null 2>&1; then
        nb edit "$NOTEBOOK:$filename"
    else
        echo "No entry found for $target_date (offset $raw)"
        return 1
    fi
}

# Show usage/help
cmd_help() {
    echo "Usage: j {start|end|log|sub|add|show|search|yesterday|relative ±N}"
    echo ""
    echo "Commands (shorthands):"
    echo "  start (s)                     Start a tracked activity (description added on end)"
    echo "  end (e) \"description\"         End the ongoing activity and optionally add description"
    echo "  log (l) \"description\"         Log a one-off event"
    echo "  sub (b) \"description\"         Add subpoint to last entry"
    echo "  add (a)                       Open today's note in editor"
    echo "  show (o) [date]               Show entry for date (YYYY-MM-DD)"
    echo "  search (f) \"query\"            Search all journal entries"
    echo "  yesterday (y)                 Open yesterday's entry"
    echo "  relative (r) ±N|N             Open entry N days from today (use - for past, + for future)"
}

# Main command dispatcher
cmd=$1
shift || true

case "$cmd" in
    start|s)
        cmd_start "$@"
        ;;
    end|e)
        cmd_end "$@"
        ;;
    log|l)
        cmd_log "$@"
        ;;
    sub|b)
        cmd_sub "$@"
        ;;
    add|a|"")
        cmd_add
        ;;
    show|o)
        cmd_show "$@"
        ;;
    search|f)
        cmd_search "$@"
        ;;
    yesterday|y)
        cmd_yesterday
        ;;
    relative|r)
        # accept a numeric offset as next arg
        cmd_relative "$1"
        ;;
    -[0-9]*|+[0-9]*|[0-9]*)
        # direct signed offset (e.g. -1, +2) or unsigned number
        cmd_relative "$cmd"
        ;;
    help|h)
        cmd_help
        ;;
    *)
        # default to help for unknown commands
        cmd_help
        ;;
esac
