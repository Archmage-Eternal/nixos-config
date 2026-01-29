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

# Start a tracked activity
cmd_start() {
    local description="$*"
    if [[ -z "$description" ]]; then
        echo "Error: Activity description required"
        echo "Usage: j start \"Activity description\""
        return 1
    fi
    
    ensure_note_exists
    local filename=$(get_today_filename)
    local current_time=$(get_current_time)
    
    # Check if this is the first entry (file only has heading)
    local content=$(nb show "$NOTEBOOK:$filename" --print)
    local line_count=$(echo "$content" | wc -l)
    
    if [[ $line_count -eq 1 ]]; then
        # First entry, add blank line before it
        local entry="\n- $current_time - [ongoing] : $description"
        echo -e "$entry" | nb edit "$NOTEBOOK:$filename"
    else
        # Not first entry, no blank line
        local entry="- $current_time - [ongoing] : $description"
        echo "$entry" | nb edit "$NOTEBOOK:$filename"
    fi
    echo "Started: $description"
}

# End the ongoing activity
cmd_end() {
    ensure_note_exists
    local filename=$(get_today_filename)
    local current_time=$(get_current_time)
    
    # Get the content of today's note
    local content=$(nb show "$NOTEBOOK:$filename" --print)
    
    # Check if there's an [ongoing] marker
    if ! echo "$content" | grep -q "\[ongoing\]"; then
        echo "Error: No ongoing activity found"
        return 1
    fi
    
    # Replace [ongoing] with current time
    local updated_content=$(echo "$content" | sed "s/\[ongoing\]/$current_time/")
    
    # Write back the updated content
    echo "$updated_content" | nb edit "$NOTEBOOK:$filename" --overwrite
    echo "Ended activity at $current_time"
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
    local content=$(nb show "$NOTEBOOK:$filename" --print)
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
    local filename=$(get_today_filename)
    local today=$(date +%F)
    
    if nb show "$NOTEBOOK:$filename" > /dev/null 2>&1; then
        nb edit "$NOTEBOOK:$filename"
    else
        nb new "$NOTEBOOK:$filename" --content "$(echo -e "# $today\n")"
        nb edit "$NOTEBOOK:$filename"
    fi
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

# Show recent entries
cmd_recent() {
    local days="${1:-7}"
    
    echo "Recent journal entries (last $days days):"
    echo "========================================="
    
    for i in $(seq $((days - 1)) -1 0); do
        local filename=$(get_offset_filename -$i)
        local date=$(date -d "-$i days" +%F)
        
        if nb show "$NOTEBOOK:$filename" > /dev/null 2>&1; then
            echo -e "\n[$date]"
            nb show "$NOTEBOOK:$filename" --print | head -10
            echo "..."
        fi
    done
}

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

# Handle relative day navigation (e.g., -1, +2)
cmd_relative() {
    local offset=$1
    local filename=$(get_offset_filename "$offset")
    local target_date=$(date -d "$offset days" +%F)
    
    if nb show "$NOTEBOOK:$filename" > /dev/null 2>&1; then
        nb edit "$NOTEBOOK:$filename"
    else
        nb new "$NOTEBOOK:$filename" --content "$(echo -e "# $target_date\n")"
        nb edit "$NOTEBOOK:$filename"
    fi
}

# Main command dispatcher
cmd=$1
shift || true

case "$cmd" in
    start)
        cmd_start "$@"
        ;;
    end)
        cmd_end
        ;;
    log)
        cmd_log "$@"
        ;;
    sub)
        cmd_sub "$@"
        ;;
    add|"")
        cmd_add
        ;;
    show)
        cmd_show "$@"
        ;;
    recent)
        cmd_recent "$@"
        ;;
    search)
        cmd_search "$@"
        ;;
    yesterday)
        cmd_yesterday
        ;;
    -[0-9]*|+[0-9]*)
        cmd_relative "$cmd"
        ;;
    *)
        echo "Usage: j {start|end|log|sub|add|show|recent|search|yesterday|±N}"
        echo ""
        echo "Commands:"
        echo "  start \"description\"   Start a tracked activity"
        echo "  end                   End the ongoing activity"
        echo "  log \"description\"     Log a one-off event"
        echo "  sub \"description\"     Add subpoint to last entry"
        echo "  add | (no args)       Open today's note in editor"
        echo "  show [date]           Show entry for date (YYYY-MM-DD)"
        echo "  recent [n]            Show last n days (default: 7)"
        echo "  search <query>        Search all journal entries"
        echo "  yesterday             Open yesterday's entry"
        echo "  -N | +N               Open entry N days ago/from now"
        ;;
esac
