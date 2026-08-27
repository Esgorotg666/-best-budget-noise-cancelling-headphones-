#!/usr/bin/env bash
# Records gameplay from the Android cloud VM and pulls the clip down to
# this device. Android's screenrecord caps a single take at 180s.
. "$(dirname "${BASH_SOURCE[0]}")/_lib.sh"

DURATION="${1:-15}"
if [ "$DURATION" -gt 180 ]; then
  echo "Max clip length is 180s (Android's screenrecord limit)." >&2
  exit 1
fi

REMOTE_CLIP="clip-$(date +%s).mp4"

echo "Recording ${DURATION}s of gameplay..."
gameops_ssh "cd $GAMEOPS_COMPOSE_DIR && \
  docker compose exec -T redroid screenrecord --time-limit $DURATION /sdcard/$REMOTE_CLIP && \
  docker compose cp redroid:/sdcard/$REMOTE_CLIP ./$REMOTE_CLIP"

echo "Pulling clip to this device..."
scp -i "$GAMEOPS_SSH_KEY" "$GAMEOPS_USER@$GAMEOPS_HOST:$GAMEOPS_COMPOSE_DIR/$REMOTE_CLIP" "./$REMOTE_CLIP"

echo "Cleaning up remote copy..."
gameops_ssh "cd $GAMEOPS_COMPOSE_DIR && rm -f ./$REMOTE_CLIP"

echo "Saved locally as $REMOTE_CLIP — find it in a-Shell's home directory via the Files app."
