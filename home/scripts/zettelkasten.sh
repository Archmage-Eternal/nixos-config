#!/usr/bin/env bash

NOTEBOOK="zettelkasten"

get_usage() {
    cat <<EOF
Usage: z {add|open|search|delete|help}

Commands:
    add (a)    [-t <title>] [--tags <tag1>,<tag2>...]
                              Create a new note and open in \$EDITOR.
                              Uses a timestamp filename by default.
    open (o)   [--last | --tag <tag> | <query>]
                              Open a note for editing.
                                --last        Open the most recently edited note.
                                --tag <tag>   Pick from notes tagged <tag>.
                                <query>       Search and pick from results.
                                (none)        Prompt for a search term interactively.
    search (s) [--tag <tag> | <query>]
                              Full-text search (shows excerpts).
                                --tag <tag>   Search by tag.
    delete (d) [--tag <tag> | <query>]
                              Search, pick from results, then confirm deletion.
    help (h)                  Show this help.
EOF
}

# _fzf_pick [--tag <tag>] [<query...>]
# If a query/tag is given, pre-filters with nb search --list then lets the
# user interactively pick with fzf (+ a live note preview).
# If no arguments, lists every note in the notebook and lets fzf do all
# the filtering interactively.
# Prints the chosen numeric nb id to stdout. Returns 1 if nothing picked.
_fzf_pick() {
    local prompt="zettelkasten"
    local use_search=0
    local -a search_args=()

    if [[ "${1:-}" == "--tag" && -n "${2:-}" ]]; then
        search_args=("$NOTEBOOK:" --tag "$2" --list)
        prompt="tag:$2"
        use_search=1
    elif [[ $# -gt 0 ]]; then
        search_args=("$NOTEBOOK:" "$*" --list)
        prompt="$*"
        use_search=1
    fi

    local raw
    if [[ $use_search -eq 1 ]]; then
        raw=$(nb search "${search_args[@]}" --no-color 2>/dev/null)
    else
        # No query — list every note; fzf handles all interactive filtering
        raw=$(nb list "$NOTEBOOK:" --no-color 2>/dev/null)
    fi

    local candidates
    candidates=$(echo "$raw" | grep -E '^\[[^]]+\]')

    if [[ -z "$candidates" ]]; then
        echo "No notes found${prompt:+ for \"$prompt\"}." >&2
        return 1
    fi

    # fzf with a right-hand pane previewing the note content
    local selected
    selected=$(echo "$candidates" \
        | fzf --ansi \
              --prompt="$prompt > " \
              --preview="nb show \"zettelkasten:\$(echo {} | grep -oP '(?<=\\[)[^\\]]+(?=\\])' | grep -oP '[0-9]+$')\" --print --no-color 2>/dev/null | bat --language=md --style=plain --color=always" \
              --preview-window=right:60%:wrap \
              --height=80%)

    [[ -z "$selected" ]] && return 1

    # Extract full id between brackets (may be "3" or "zettelkasten:3"), normalise
    local raw_id
    raw_id=$(echo "$selected" | grep -oP '(?<=\[)[^]]+(?=\])')
    [[ "$raw_id" != *:* ]] && raw_id="$NOTEBOOK:$raw_id"
    echo "$raw_id"
}

cmd_add() {
    local -a args=()
    # Forward --title / -t and --tags to nb add; anything else is ignored.
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -t|--title) args+=(--title "$2"); shift 2 ;;
            --tags)     args+=(--tags  "$2"); shift 2 ;;
            *) shift ;;
        esac
    done
    nb add "$NOTEBOOK:" "${args[@]}"
}

cmd_open() {
    # --last / -l: bypass the picker, open the most recently edited note directly
    if [[ "${1:-}" == "--last" || "${1:-}" == "-l" ]]; then
        local last_raw
        last_raw=$(nb list "$NOTEBOOK:" --limit 1 --no-color 2>/dev/null \
                   | grep -oP '(?<=\[)[^]]+(?=\])')
        if [[ -z "$last_raw" ]]; then
            echo "No notes found in $NOTEBOOK." >&2
            return 1
        fi
        [[ "$last_raw" != *:* ]] && last_raw="$NOTEBOOK:$last_raw"
        nb edit "$last_raw"
        return
    fi

    # No args: browse all notes in fzf
    # With args (query or --tag): pre-filter via nb search, then fzf within those
    local nb_id
    nb_id=$(_fzf_pick "$@") || return 1
    nb edit "$nb_id"
}

cmd_search() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: z search [--tag <tag> | <query>]" >&2
        return 1
    fi
    # Pass all args straight through — supports --tag, --and, --or, --not, etc.
    nb search "$NOTEBOOK:" "$@"
}

cmd_delete() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: z delete [--tag <tag> | <query>]" >&2
        return 1
    fi

    local nb_id
    nb_id=$(_fzf_pick "$@") || return 1

    # Show what will be deleted
    local info
    info=$(nb show "$nb_id" --info-line --no-color 2>/dev/null)
    echo "" >&2
    echo "About to delete: $info" >&2
    echo -n "Confirm? [y/N] " >&2
    read -r confirm
    [[ "$confirm" =~ ^[Yy]$ ]] || { echo "Aborted." >&2; return 1; }

    nb delete "$nb_id" --force
}

case "${1:-}" in
    add|a)
        shift
        cmd_add "$@"
        ;;
    open|o|edit|e)
        shift
        cmd_open "$@"
        ;;
    search|s)
        shift
        cmd_search "$@"
        ;;
    delete|d)
        shift
        cmd_delete "$@"
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
