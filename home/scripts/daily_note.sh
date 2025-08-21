#!/usr/bin/env bash
NOTEBOOK="journal"
today=$(date +%F)        # e.g. 2025-08-20
filename="$today.md"     # force .md extension

if nb show "$NOTEBOOK:$filename" > /dev/null 2>&1; then
        nb edit "$NOTEBOOK:$filename"
else
        nb new "$NOTEBOOK:$filename" --content "$(echo -e "# $today\n")"
        nb edit "$NOTEBOOK:$filename"
fi

