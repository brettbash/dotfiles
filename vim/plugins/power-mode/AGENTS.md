# neovim-power-mode — Agent Guide

VS Code Power Mode for Neovim. Spawns particle effects, a combo counter, screen shake, and a fire wall as you type.

---

## Architecture

```
plugin/power-mode.lua       ← entry point; user commands; auto-setup guard
lua/power-mode/
  init.lua                  ← orchestrator: setup/enable/disable/toggle
  config.lua                ← defaults, vim globals, user opts → merged config
  engine.lua                ← animation loop (libuv timer at configurable FPS)
  particles.lua             ← preset dispatcher (load, swap, cancel-on-new)
  renderer.lua              ← floating window pool for particle rendering
  combo.lua                 ← combo counter floating window
  shake.lua                 ← screen shake (none / scroll / applescript)
  fire_wall.lua             ← bottom-of-editor heat buffer fire effect
  highlights.lua            ← creates all highlight groups from config
  utils.lua                 ← math helpers (random, clamp, lerp, dimensions)
  presets/
    rightburst.lua          ← arrows flying right (default)
    stars.lua               ← twinkling star symbols
    explosion.lua           ← radial burst with upward bias
    fountain.lua            ← narrow upward geyser
    shockwave.lua           ← expanding ring
    emoji.lua               ← emoji particles
    disintegrate.lua        ← actual buffer chars shatter outward
    fire.lua                ← downward embers (used for backspace, not a user preset)
```

### Data Flow on Keystroke

```
InsertCharPre autocmd
  → particles.spawn(row, col)      dispatches to current preset module
  → combo.increment()              updates streak/level/timeout bar
  → shake.trigger(level)           optional viewport jitter
  → fire_wall.spawn(level, streak) seeds heat buffer if enabled

engine timer (every N ms at cfg.engine.fps)
  → particles.update(dt)
  → fire.update(dt)                (backspace embers)
  → fire_wall.update(dt)
  → renderer.render(all_active)    places pool windows at particle positions
  → combo.update(dt)               ticks timeout bar, resets on expiry
```

---

## Configuration (`lua/power-mode/config.lua`)

Resolution order (later wins): **defaults → vim globals → `setup()` opts**

Key sections:

| Key | Description |
|-----|-------------|
| `particles` | preset name, physics (gravity/drag/speed/lifetime), pool/max sizes |
| `backspace` | fire effect on `<BS>`/`<Del>` |
| `colors` | 8 color slots used by particle highlight groups |
| `combo` | floating window position, thresholds, exclamations, level colors |
| `shake` | mode (`none`/`scroll`/`applescript`), magnitude, interval |
| `fire_wall` | enabled, bottom_offset, max_rows |
| `engine` | fps (10–60), stop_delay |

`config.get()` returns the live merged table. Mutating it at runtime takes effect on the next frame.

---

## Particle Object Shape

Every active particle passed to the renderer must have:

```lua
{
  x, y,            -- screen position (float, col/row)
  vx, vy,          -- velocity (screen units per second)
  char,            -- display character (string, may be multi-byte)
  color_idx,       -- 1–8, maps to PowerModeParticle{N} highlight group
  lifetime,        -- ms remaining
  max_lifetime,    -- ms at birth (used to compute winblend fade)
}
```

Optional fields used by some presets: `twinkle_phase`, `twinkle_speed`, `tumble_idx`, `is_emoji`.

---

## Adding a New Preset

1. Create `lua/power-mode/presets/mything.lua` implementing:

```lua
local M = {}
local active = {}

function M.spawn(row, col)  -- add entries to `active` end
function M.update(dt)       -- advance physics, remove dead particles end
function M.get_active()  return active  end
function M.clear()       active = {}   end

return M
```

2. Register it in `lua/power-mode/particles.lua`:

```lua
local builtin_presets = {
  -- existing entries ...
  mything = "power-mode.presets.mything",
}
```

3. Expose it in the `:PowerModeStyle` completion list in `plugin/power-mode.lua`:

```lua
complete = function()
  return { "rightburst", "stars", ..., "mything" }
end,
```

No other files need changing.

---

## Highlight Groups

| Group | Used by |
|-------|---------|
| `PowerModeParticle1`–`8` | particle renderer, one per `color_idx` |
| `PowerModeCombo0`–`4` | combo window, one per level; bg per-level since v2 |
| `PowerModeFire1`–`5` | fire wall heat rendering |
| `PowerModeFireBg` | fire wall window background |

Groups are (re-)created in `highlights.setup()` and `fire_wall.init()`. Both are called on `ColorScheme` to survive `:hi clear`.

---

## Key Modules

### `engine.lua`
Owns the single `vim.loop` timer. Call `engine.start()` / `engine.stop()`. Modules are injected via `engine.set_modules(particles, fire, renderer, combo, fire_wall)` at setup time to avoid circular requires.

### `renderer.lua`
Maintains a fixed pool of `cfg.particles.pool_size` floating 1×1 windows. Each frame: assign live particles to pool slots, move unused slots off-screen (`row = -10`). Winblend is set to `100 * (1 - lifetime/max_lifetime)` for fade-out.

### `combo.lua`
All state is module-local. Public API: `increment()`, `reset()`, `update(dt)`, `get_level()`, `get_streak()`, `ensure_window()`, `reposition()`, `cleanup()`. The `set_on_reset(cb)` hook is used by `init.lua` to trigger `fire_wall.cool_down()`.

### `fire_wall.lua`
Classic 2D heat-buffer (cacafire algorithm). Grid seeded at bottom row on each `spawn()` call; propagates upward with cooling each frame. Visible rows grow with combo level (hidden below level 2). Calls `cool_down()` when combo resets; grid drains naturally, window hides when fully cold.

### `shake.lua`
- `scroll`: saves `topline`, jitters by `magnitude`, restores after `restore_delay` ms.
- `applescript`: fires an `osascript` job to move the iTerm2 window and snap back. macOS + iTerm2 only.

---

## User Commands

| Command | Action |
|---------|--------|
| `:PowerModeToggle` | enable ↔ disable |
| `:PowerModeEnable` / `:PowerModeDisable` | explicit on/off |
| `:PowerModeStyle <preset>` | swap particle preset live |
| `:PowerModeShake <none\|scroll\|applescript>` | change shake mode |
| `:PowerModeFireWall <on\|off>` | toggle fire wall |
| `:PowerModeInterrupt <on\|off>` | cancel previous particles on new keystroke |
| `:PowerModeStatus` | print current config snapshot |

---

## Conventions

- All modules return a single table `M`; no global state leaks.
- `pcall` wraps every nvim API call that touches windows/buffers (they can be closed externally).
- `vim.schedule` is used inside libuv timer callbacks to safely call nvim API.
- `utils.random_int(min, max)` wraps `math.random`; seed is set once in `utils.lua`.
- Physics `dt` is in **seconds** (engine divides `ms` difference by 1000). Lifetime fields are in **milliseconds**.
- Particle lists use swap-remove (`active[i] = active[#active]; active[#active] = nil`) for O(1) deletion.
