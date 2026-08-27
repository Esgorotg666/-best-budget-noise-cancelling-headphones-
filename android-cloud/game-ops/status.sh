#!/usr/bin/env bash
# Prints whether the Android cloud VM is up. Good target for a home
# screen widget or a Shortcuts automation that just needs a yes/no.
. "$(dirname "${BASH_SOURCE[0]}")/_lib.sh"

state="$(gameops_ssh "cd $GAMEOPS_COMPOSE_DIR && docker compose ps --status running -q redroid" 2>/dev/null || true)"

if [ -n "$state" ]; then
  echo "RUNNING — https://$GAMEOPS_HOST"
else
  echo "STOPPED"
fi
