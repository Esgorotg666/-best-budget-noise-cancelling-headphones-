# Android Cloud VM for iPhone

Run Android (and Google Play) apps from your iPhone by streaming a real
Android VM from a server to Safari — no jailbreak, no App Store install,
nothing installed on the phone at all.

## Why this design, and not an on-device VM

Stock iOS does not let third-party apps run a hypervisor or boot a guest
OS — there's no public hypervisor entitlement for non-Apple apps, and
App Store apps can't JIT-compile the code a real Android runtime needs.
Jailbreaking removes those restrictions, but requires physical access to
the device, voids Apple's warranty, and breaks every time Apple patches
the exploit it depends on — the opposite of "works with the latest
updates."

Putting the VM on a server sidesteps all of that: the iPhone only ever
opens a webpage in Safari and watches a video stream of the Android
screen, sending taps/keystrokes back over the same connection. Since
Safari's baseline web APIs (WebSocket, `<video>`, Canvas) are what this
depends on — not any private iOS API — an iOS update has nothing to
break.

## What's in this folder

| File | Purpose |
|---|---|
| `docker-compose.yml` | Brings up the Android VM (`redroid`), the browser streaming server (`ws-scrcpy`), and an `nginx` TLS front door. |
| `nginx/nginx.conf` | Terminates HTTPS and proxies to `ws-scrcpy` (Safari requires a secure origin). |
| `setup-tls.sh` | Generates a self-signed cert for first-run testing. |

## Requirements

- A Linux server (cloud VM or your own machine) with:
  - Docker + Docker Compose
  - Nested virtualization / `/dev/kvm` available
  - The `binder` and `ashmem` kernel modules loaded (`redroid`'s Android
    container needs these from the host kernel — see the
    [redroid project docs](https://github.com/remote-android/redroid-doc)
    for your distro's setup)
- A domain name pointed at the server, for a real TLS cert (recommended
  once you're past local testing — see below)

## Quick start

```bash
cd android-cloud
./setup-tls.sh          # self-signed cert for first-run testing
docker compose up -d
```

Then, on your iPhone, open Safari and go to `https://<your-server>/`.
Safari will warn about the self-signed cert on first load — accept it to
continue testing, and switch to a real certificate (e.g. via `certbot`)
before using this beyond your own testing. You'll land on the
`ws-scrcpy` device list; select the `redroid` device to get a live,
touch-controlled view of the Android screen.

## Installing apps

Once connected:
- **Sideloaded APKs**: `adb -H <your-server> -P 5555 install app.apk`
- **Google Play**: the base `redroid` image ships plain AOSP without
  Google Mobile Services. Getting Play Store working means layering
  GApps into the image yourself (see redroid's docs on GApps images) or
  building your own image with
  [OpenGApps](https://opengapps.org/)/[MindTheGapps](https://gitlab.com/MindTheGapps).
  **Read the licensing terms before doing this** — GApps are Google's
  proprietary binaries, redistributing a pre-baked image with them
  bundled in is legally gray even though building your own locally for
  personal use is common practice. This repo intentionally does not
  ship a GApps image for you.

## Scaling to more than one user

This compose file runs one Android VM. For multiple simultaneous users
you'd run one `redroid` (+ matching `ws-scrcpy` route) per user and put
them behind the same `nginx`, or move orchestration to something like
Kubernetes. Not included here since it's a capacity-planning decision,
not a code one — start with one instance and grow from there.
