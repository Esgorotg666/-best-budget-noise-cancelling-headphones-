# 🌊 Ocean Monster & Slots Arcade

A browser-based arcade game platform inspired by Juwa 2.0. Built in pure HTML/CSS/JavaScript — no frameworks, no installs, just open and play.

---

## 🕹️ Games

### 🐟 Fish Shooting
Canvas-based fish shooting arcade game with a Juwa-style corner cannon.

- **BET multiplier** (×1 → ×100) scales both shot cost and fish rewards
- **4 weapon types** — Normal, Laser (pierces all), Bomb (AOE), Electric Chain (jumps 5 fish)
- **10 fish types** including Jellyfish (freezes all fish), Octopus, Golden Koi, Dragon Boss, Boss Crab
- **Fish schools** — groups of 2–4 fish spawn together like real Juwa
- **Treasure chests** drift across the screen every 30 seconds
- **Combo multiplier** — kill fast for up to ×5 bonus rewards
- **Screen shake**, particle bursts, boss HP bar, freeze overlay

### 🌊 Deep Sea Hunter
Same as Fish Shooting but with **2× rewards**, 50% tougher fish, and faster spawn rates.  
Access via: `fish.html?room=deep`

### 🎰 Lucky Slots
3-reel slot machine with smooth CSS reel animations.

- 9 symbols including Wild (🌟) and Scatter (💠)
- Progressive jackpot that builds with every spin
- Free spins triggered by 3 scatters
- Auto-spin (10 / 25 / 50 / 100 rounds)
- VIP points earned on wins

### 🕹️ Retro Arcade
Bring-your-own-ROM emulator (NES / SNES / Game Boy / GBA / Genesis / Game Gear) powered by [EmulatorJS](https://emulatorjs.org/), running entirely client-side in your browser — nothing is uploaded anywhere. You supply your own legally-owned ROM files. See `retro.html`.

---

## 🌐 Play Online

| Game | Link |
|------|------|
| 🏠 Lobby | `https://esgorotg666.github.io/OceanArcade/` |
| 🐟 Fish Shooting | `https://esgorotg666.github.io/OceanArcade/fish.html` |
| 🌊 Deep Sea Hunter | `https://esgorotg666.github.io/OceanArcade/fish.html?room=deep` |
| 🎰 Lucky Slots | `https://esgorotg666.github.io/OceanArcade/slots.html` |
| 🕹️ Retro Arcade | `https://esgorotg666.github.io/OceanArcade/retro.html` |

---

## 🎯 Controls

### Fish Game
| Input | Action |
|-------|--------|
| Click / Tap | Shoot |
| Hold | Auto-fire |
| `1` – `7` | Select bet level |
| `Q` `W` `E` `R` | Switch weapon type |
| `Space` / `Esc` | Pause |

### Slots
| Input | Action |
|-------|--------|
| SPIN button | Manual spin |
| AUTO button | Auto-spin mode |
| Bet buttons | Set bet amount |

---

## 💰 Shared Wallet

All games share a single coin wallet stored in `localStorage`. Coins earned in Fish Shooting can be spent in Slots and vice versa. The lobby includes a free coin claim (30-minute cooldown) and a daily login streak bonus.

---

## 🏆 VIP System

| Level | Points Required |
|-------|----------------|
| 🥉 Bronze | 0 |
| 🥈 Silver | 500 |
| 🥇 Gold | 2,000 |
| 💎 Platinum | 6,000 |
| 🔮 Diamond | 15,000 |

---

## 🛠️ Tech Stack

- Pure **HTML5 / CSS3 / JavaScript** — zero dependencies
- **Canvas 2D API** for fish game rendering and lobby background
- **Web Audio API** for all sound effects (no audio files)
- **CSS transitions** with `cubic-bezier` for slot reel animation
- **localStorage** for persistent wallet, VIP, streak, and jackpot data

---

## ☁️ Android Cloud VM (optional, separate project)

`android-cloud/` contains a self-hosted setup for streaming a real
Android VM (with sideloadable APKs) to any browser, including iPhone
Safari — plus `game-ops/`, a set of scripts for controlling that VM
from [a-Shell](https://apps.apple.com/app/a-shell/id1473805438) on your
phone. This is unrelated to the arcade games above and requires your
own Linux server. See `android-cloud/README.md` for details.
