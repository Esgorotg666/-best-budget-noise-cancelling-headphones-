#!/usr/bin/env bash
# Shuts the Android cloud VM down so it stops costing you server money
# while you're not playing.
. "$(dirname "${BASH_SOURCE[0]}")/_lib.sh"

echo "Stopping Android cloud VM on $GAMEOPS_HOST..."
gameops_ssh "cd $GAMEOPS_COMPOSE_DIR && docker compose down"
echo "Stopped."
