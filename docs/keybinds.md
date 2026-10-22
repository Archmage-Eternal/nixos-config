# Changing keybinds

Keybinds are stored once as compositor-agnostic data and translated into each
compositor's native syntax by a per-compositor builder. To change a bind you
edit the data; the builder regenerates the compositor config automatically.

## The three pieces

| File | Role |
|------|------|
| `modules/desktop/keybinds [n]/keybinds.nix` | **Schema.** Defines `keybinds.apps` and `keybinds.actions`, and the list of valid action verbs. |
| `modules/users/david [Nn]/keybinds.nix` | **Your data.** The actual `combo -> action` map. This is the file you edit day to day. |
| `modules/desktop/hyprland [Nn]/bind-translate.nix` | **Hyprland builder.** Reads `keybinds.*` and emits Lua `hl.bind(...)`. You rarely touch this. |

Flow: `your keybinds.nix` (data) -> `bind-translate.nix` (builder) -> `hyprland.lua` (generated).

## Combo format

In the registry, combos are **comma-style**: modifiers space-separated, then a
comma, then the key.

```
"SUPER, F"            # Super + F
"SUPER SHIFT, H"      # Super + Shift + H
"SUPER CTRL, J"       # Super + Ctrl + J
```

The Hyprland builder rewrites this to plus-style (`SUPER + F`) when it generates
Lua. You always write comma-style; the builder handles the conversion. This
keeps the data neutral so a future compositor builder can format it its own way.

## Example: move fullscreen to Super+F, floating to Super+Space

Edit `modules/users/david [Nn]/keybinds.nix`. Find the window-state binds and
change them:

```nix
# before
"SUPER, M" = {action = "toggleFullscreen";};
"SUPER, F" = {action = "toggleFloating";};

# after
"SUPER, F" = {action = "toggleFullscreen";};
"SUPER, Space" = {action = "toggleFloating";};
```

That's the whole change. Rebuild (`nixos-rebuild switch --flake .#daedalus`, or
just `nix flake check` to validate), and `hyprland.lua` is regenerated with the
new binds. You did not touch the builder or the schema.

## Action verbs (what you can bind)

Set exactly one of `app`, `run`, or `action` per entry.

- `app = "terminal"` — launch an app by name. The command comes from
  `keybinds.apps.<name>`, contributed by that app's own module. Swap the app
  module later and the bind stays the same.
- `run = "grim -g ..."` — run a literal shell command.
- `action = "<verb>"` — a window-management verb. Current verbs:
  - `focusDirection` + `dir = "l"|"r"|"u"|"d"`
  - `moveWindowDirection` + `dir = ...`
  - `workspaceRelative` + `delta = 1 | -1`
  - `workspaceGoto` + `index = N`
  - `moveToWorkspaceRelative` + `delta = ...`
  - `moveToWorkspaceGoto` + `index = N`
  - `toggleFullscreen`
  - `toggleFloating`

## Collisions are caught for you

Each combo is an attribute key. Two entries with the same combo in one file is a
Nix parse error; the same combo set by two different modules is a module-system
"conflicting definitions" error. Either way `nix flake check` fails loudly — no
silent last-write-wins.

## When you DO touch a compositor builder

Only when you need an action that has no verb yet (e.g. "toggle a group"). Then:

1. Add the verb to the `action` enum in the schema (`keybinds.nix`).
2. Add a branch for it in each compositor builder (`bind-translate.nix`) mapping
   it to that compositor's dispatcher.
3. Use it in your data file.

Changing *which key* triggers an *existing* action never requires this — it's
always just the data file.
