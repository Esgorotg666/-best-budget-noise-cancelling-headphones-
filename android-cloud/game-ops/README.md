# Game Ops — control the Android cloud VM from a-Shell

One-tap start/stop/status/install for the Android cloud VM (see the
[parent README](../README.md)), run from a-Shell on your iPhone so you
never need a laptop to manage it.

## Setup (one-time)

1. **Install [a-Shell](https://apps.apple.com/app/a-shell/id1473805438)** from the App Store.

2. **Generate an SSH key in a-Shell** (if you don't already have one there):
   ```bash
   ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519
   ```
   Add the printed public key (`~/.ssh/id_ed25519.pub`) to your server's
   `~/.ssh/authorized_keys`.

3. **Clone this repo into a-Shell:**
   ```bash
   git clone https://github.com/Esgorotg666/OceanArcade.git
   cd OceanArcade/android-cloud/game-ops
   ```

4. **Set up your config:**
   ```bash
   cp config.sh.example config.sh
   vim config.sh   # fill in your server's hostname, ssh user, etc.
   ```
   `config.sh` is gitignored — it holds your server details and never
   gets committed.

5. **Make sure your server has `docker compose` v2** (the scripts use
   `docker compose exec`/`docker compose cp`, not the standalone
   `docker-compose` v1 syntax).

## Commands

Run these from `OceanArcade/android-cloud/game-ops/` in a-Shell:

| Command | What it does |
|---|---|
| `./start.sh` | Boots the VM, waits for Android to finish booting, tells you when it's ready |
| `./stop.sh` | Shuts the VM down (stop paying for idle server time) |
| `./status.sh` | Prints `RUNNING` or `STOPPED` |
| `./apk.sh list` | Lists installed (non-system) apps |
| `./apk.sh install <path.apk>` | Uploads and installs an APK from your device |
| `./apk.sh uninstall <package>` | Removes an installed app |
| `./record.sh [seconds]` | Records gameplay (default 15s, max 180s) and pulls the clip to your phone |

## Wiring up Siri Shortcuts (optional)

a-Shell supports a URL scheme that runs a command and returns to the
calling app. Create a Shortcut with an **Open URL** action pointing at:

```
a-shell://run?command=cd%20OceanArcade/android-cloud/game-ops%20%26%26%20./start.sh
```

(swap `start.sh` for `stop.sh`/`status.sh` for other Shortcuts). Name the
Shortcut something like "Start Game Server" and add it to your home
screen or ask Siri to run it — that's the one-tap boot described in the
main writeup.

## Security notes

- `config.sh` contains your server hostname and ssh key path — don't
  commit it (the `.gitignore` here already excludes it, don't override
  that).
- These scripts assume your ssh key has no passphrase (a-Shell can't
  prompt interactively from a Shortcut). Restrict what that key can do
  on the server side (a dedicated deploy user, `command=` restriction in
  `authorized_keys`, etc.) if you're security-conscious — it's a
  meaningful step up from a full login key and worth doing before you
  wire this into an automation that runs unattended.
