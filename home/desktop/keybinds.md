
---

## Expanded keybinds and compositor-specific notes

Below are more keybind categories and suggested bindings. These are intended as a starting point — pick or tweak the combinations you like. Where relevant I mark whether a binding is particularly useful for Hyprland (dynamic tiling) or Niri (scrolling / stack-oriented).

### Suggested modifier keys
- Super (Mod) — main modifier for window management and workspace operations
- Shift — move or modify windows
- Ctrl — fine adjustments or resize modifiers
- Alt — alternative modifier for app launching or special actions

### Application / Launcher
- Super + Return — Launch terminal (existing)
- Super + b — Launch browser (existing)
- Super + Space — Overview / launcher (existing)
- Super + p — Quick run prompt / rofi / dmenu (good for Hyprland and Niri)

### Window & Focus (general)
- Super + h / j / k / l — Focus left / down / up / right (existing)
- Super + Shift + h / j / k / l — Move window in that direction (existing)
- Super + Ctrl + h / l — Resize left / right (existing)
- Super + / — Toggle last focused window (Alt-Tab style)
- Super + Tab — Cycle clients on current workspace (useful in both compositors)

### Workspace handling
- Super + [1-9] — Switch to workspace N (existing)
- Super + Shift + [1-9] — Move focused window to workspace N (existing)
- Super + j / k — Next / previous workspace (note: conflicts with focus; consider remapping in Hyprland where focus keys may be different)
- Super + . / , — Create / remove temporary workspace (advanced)

### Floating, Tiling & Layout toggles
- Super + Shift + f — Toggle floating (existing)
- Super + t — Toggle tiling mode for focused window (makes it participate / not in tiling)
- Super + y — Toggle split orientation (vertical/horizontal) for the current container (Hyprland)
- Super + space (double-tap) — Toggle between last two layouts

### Scratchpad and quick-terminate
- Super + ` (tilde) — Toggle terminal scratchpad
- Super + n — Toggle notes scratchpad (notes app is nvim aliased to vi, can be triggered with a script to open a scratch pad notebook managed via the nb cli tool)
- Super + z — Toggle notes scratchpad (notes app is nvim aliased to vi, can be triggered with a script to open the zettelkasten managed via the nb cli tool)
- Super + q — Close window (existing)

### Special actions (screenshots, recording, clipboard)
- Print — Full screenshot (existing)
- Super + Shift + s — Area screenshot
- Super + Shift + r — Start/stop screen recording (wf-recorder/obs wrapper)
- Super + c — Copy selection to clipboard or open clipboard manager is this redundant

### Media & Volume (existing but grouped)
- XF86AudioRaiseVolume / XF86AudioLowerVolume / XF86AudioMute (existing)
- XF86AudioPlay / XF86AudioPrev / XF86AudioNext — Media controls

### Session / Power (existing but explicit)
- Super + Escape or Super + L — Lock screen (existing)
- Super + Shift + e — Logout / Exit WM (existing)
- Super + Ctrl + Power — Reboot / Power menu

### Accessibility / Focus helpers
- Super + F — Focus follow mouse toggle
- Super + z — Zoom / magnifier toggle

### Monitor / Output controls (Hyprland-heavy)
Likey not needed
- Super + o — Cycle active output
- Super + Shift + o — Move focused window to next output
- Super + F1..F12 or Super + Ctrl + [←/→] — Change output layout / mirror / rotate

---

## Hyprland-specific suggestions

Notes: Hyprland is a dynamic tiling Wayland compositor with lots of runtime control via bindings and `hyprctl`. Hyprland users benefit from workspace/output controls, layout toggles, and scratchpads.

- Keep Super as the main modifier.
- Prefer single-key combos for common actions (Super+Return, Super+q, Super+f).
- Use `hyprctl` to script advanced behavior (move to output, set workspace, toggle layouts).

Example Hyprland ideas (conceptual; I can generate exact `hyprland.conf` lines later):

- Super + Return → spawn terminal
- Super + b → spawn browser
- Super + Shift + f → toggle floating for active window
- Super + y → cycle split orientation
- Super + Shift + j / k → move window between workspaces
- Super + Shift + o → move focused window to next output
- Super + ` → toggle terminal scratchpad (spawn or hide)

Hyprland testing tip: after editing your `hyprland.conf`, use the compositor's reload mechanism (or restart) to apply changes and test quickly.

---

## Niri-specific suggestions

Notes: Niri is a session manager / stacking compositor style (scrolling windows). Because window stacking and navigation differ from dynamic tiling, emphasize keyboard navigation, focused-scrolling controls, and fewer tiling-specific toggles.

- Use Super for launching and session controls.
- Use Alt or Ctrl for fine-grained focus movement if Niri's scroll navigation uses gestures/scroll.

Suggested Niri-friendly bindings:

- Super + Return → launch terminal
- Super + b → launch browser
- Super + Space → overview / app launcher
- Super + h / l → previous / next window in stack
- Super + Shift + h / l → move focused window up / down in stack
- Super + m → minimize / unminimize focused window
- Super + ` → quick toggle scratchpad terminal

Note: Niri's configuration format differs from Hyprland. If you'd like, I can produce exact Niri config snippets once we settle on the final set of keybinds.

---

## Mapping plan and next steps

1. Pick which of the above suggested binds you want to keep or change.
2. I can generate exact Hyprland `bind` lines and a sample `hyprland.conf` snippet (todo: generate Hyprland snippets).
3. I can then produce Niri-ready bindings or notes for incorporating the keys into the Niri session (todo: generate Niri snippets).

If you want, tell me the few bindings you'd like to change from your current list and I will produce ready-to-paste snippets for Hyprland and Niri.


