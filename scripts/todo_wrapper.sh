#!/usr/bin/env bash
NOTEBOOK="todo"

cmd=$1
shift || true

case "$cmd" in
  add)
    nb todo "$NOTEBOOK:$*"
    ;;
  list)
    nb todos "$NOTEBOOK"
    ;;
  done)
    nb done "$@"
    ;;
  undone)
    nb undone "$@"
    ;;
  rm|remove|delete)
    nb rm "$@"
    ;;
  *)
    echo "Usage: todo {add|list|done|undone|rm} ..."
    ;;
esac

