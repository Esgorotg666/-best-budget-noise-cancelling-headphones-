# Shared helpers, sourced by the other game-ops scripts.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/config.sh"

if [ ! -f "$CONFIG_FILE" ]; then
  echo "Missing $CONFIG_FILE — copy config.sh.example to config.sh and fill it in first." >&2
  exit 1
fi
# shellcheck source=/dev/null
. "$CONFIG_FILE"

gameops_ssh() {
  ssh -i "$GAMEOPS_SSH_KEY" -o BatchMode=yes "$GAMEOPS_USER@$GAMEOPS_HOST" "$@"
}
