#!/usr/bin/env bash
# Manage which game APKs are installed on the Android cloud VM, from
# a-Shell, without needing adb installed anywhere (uses `pm` inside the
# container directly).
. "$(dirname "${BASH_SOURCE[0]}")/_lib.sh"

usage() {
  echo "Usage:"
  echo "  apk.sh list                  List installed (non-system) apps"
  echo "  apk.sh install <path.apk>    Upload and install an APK"
  echo "  apk.sh uninstall <package>   Remove an installed app"
  exit 1
}

cmd="${1:-}"
case "$cmd" in
  list)
    gameops_ssh "cd $GAMEOPS_COMPOSE_DIR && docker compose exec -T redroid pm list packages -3"
    ;;
  install)
    apk_path="${2:-}"
    [ -f "$apk_path" ] || { echo "File not found: $apk_path" >&2; exit 1; }
    apk_name="$(basename "$apk_path")"
    echo "Uploading $apk_name..."
    scp -i "$GAMEOPS_SSH_KEY" "$apk_path" "$GAMEOPS_USER@$GAMEOPS_HOST:$GAMEOPS_COMPOSE_DIR/$apk_name"
    echo "Installing..."
    gameops_ssh "cd $GAMEOPS_COMPOSE_DIR && \
      docker compose cp ./$apk_name redroid:/data/local/tmp/$apk_name && \
      docker compose exec -T redroid pm install -r /data/local/tmp/$apk_name && \
      rm ./$apk_name"
    echo "Installed $apk_name."
    ;;
  uninstall)
    package="${2:-}"
    [ -n "$package" ] || usage
    gameops_ssh "cd $GAMEOPS_COMPOSE_DIR && docker compose exec -T redroid pm uninstall $package"
    ;;
  *)
    usage
    ;;
esac
