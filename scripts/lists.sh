#!/usr/bin/env bash

NOTEBOOK="lists"

get_usage() {
    cat <<EOF
Usage: l {add|open|search|delete|help}

Commands:
    add (a)    [-t <title>] [--tags <tag1>,<tag2>...]
                              Create a new list and open in \$EDITOR.
                              Prompts for a title if -t is not given.
    open (o)   [--last | --tag <tag> | <query>]
                              Open a list for editing (fzf picker).
                                --last        Open the most recently edited list.
                                --tag <tag>   Filter by tag.
                                <query>       Pre-filter by search term.
                                (none)        Browse all lists.
    search (s) [--tag <tag> | <query>]
                              Full-text search across all lists.
    delete (d) [--tag <tag> | <query>]
                              Pick a list via fzf and delete with confirmation.
    help (h)                  Show this help.
EOF
}

# _fzf_pick [--tag <tag>] [<query...>]
# Lists every note or pre-filters by search/tag, then presents an fzf picker
# with a bat-highlighted preview pane.
# Returns a normalised notebook:id selector on stdout.
_fzf_pick() {
    local prompt="lists"
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
        raw=$(nb list "$NOTEBOOK:" --no-color 2>/dev/null)
    fi

    local candidates
    candidates=$(echo "$raw" | grep -E '^\[[^]]+\]')

    if [[ -z "$candidates" ]]; then
        echo "No lists found${prompt:+ for \"$prompt\"}." >&2
        return 1
    fi

    local selected
    selected=$(echo "$candidates" \
        | fzf --ansi \
              --prompt="$prompt > " \
              --preview="nb show \"lists:\$(echo {} | grep -oP '(?<=\\[)[^\\]]+(?=\\])' | grep -oP '[0-9]+$')\" --print --no-color 2>/dev/null | bat --language=md --style=plain --color=always" \
              --preview-window=right:60%:wrap \
              --height=80%)

    [[ -z "$selected" ]] && return 1

    local raw_id
    raw_id=$(echo "$selected" | grep -oP '(?<=\[)[^]]+(?=\])')
    [[ "$raw_id" != *:* ]] && raw_id="$NOTEBOOK:$raw_id"
    echo "$raw_id"
}

cmd_add() {
    local title=""
    local -a args=()

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -t|--title) title="$2"; shift 2 ;;
            --tags)     args+=(--tags "$2"); shift 2 ;;
            *) shift ;;
        esac
    done

    # Prompt for title if not supplied — lists should always be named
    if [[ -z "$title" ]]; then
        echo -n "List title: " >&2
        read -r title
        [[ -z "$title" ]] && { echo "Aborted." >&2; return 1; }
    fi

    nb add "$NOTEBOOK:" --title "$title" --content "# $title" "${args[@]}"
}

cmd_open() {
    if [[ "${1:-}" == "--last" || "${1:-}" == "-l" ]]; then
        local last_raw
        last_raw=$(nb list "$NOTEBOOK:" --limit 1 --no-color 2>/dev/null \
                   | grep -oP '(?<=\[)[^]]+(?=\])')
        if [[ -z "$last_raw" ]]; then
            echo "No lists found in $NOTEBOOK." >&2
            return 1
        fi
        [[ "$last_raw" != *:* ]] && last_raw="$NOTEBOOK:$last_raw"
        nb edit "$last_raw"
        return
    fi

    local nb_id
    nb_id=$(_fzf_pick "$@") || return 1
    nb edit "$nb_id"
}

cmd_search() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: l search [--tag <tag> | <query>]" >&2
        return 1
    fi
    nb search "$NOTEBOOK:" "$@"
}

cmd_delete() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: l delete [--tag <tag> | <query>]" >&2
        return 1
    fi

    local nb_id
    nb_id=$(_fzf_pick "$@") || return 1
    nb delete "$nb_id"
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
        get_usage
        ;;
    *)
        echo "Unknown command: $1" >&2
        get_usage
        exit 1
        ;;
esac
