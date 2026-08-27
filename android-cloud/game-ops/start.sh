#!/usr/bin/env bash
# Boots the Android cloud VM. Run from a-Shell, or trigger via a Siri
# Shortcut using: a-shell://run?command=game-ops/start.sh
. "$(dirname "${BASH_SOURCE[0]}")/_lib.sh"

echo "Starting Android cloud VM on $GAMEOPS_HOST..."
gameops_ssh "cd $GAMEOPS_COMPOSE_DIR && docker compose up -d"

echo "Waiting for redroid to finish booting..."
for i in $(seq 1 30); do
  if gameops_ssh "cd $GAMEOPS_COMPOSE_DIR && docker compose exec -T redroid getprop sys.boot_completed" 2>/dev/null | grep -q 1; then
    echo "Ready — open https://$GAMEOPS_HOST in Safari to play."
    exit 0
  fi
  sleep 5
done

echo "Still booting after 2.5 minutes — check logs with: docker compose logs redroid" >&2
exit 1
