# Issues

## General

- Startup time is slow in general after adding secure boot and TPM2 unlock
  - Additional slowdowns occur because of a start job that occasionally takes a lot of time to load kernel modules.
  - Additional slowdowns are caused because of how the `niri-session` is called
  - Helper script in repo: `startup-diagnostics [output-dir]`
  - Potential solutions:
    - Measure whether slowdown is in firmware, initrd, userspace, or desktop session before changing config.
    - Compare one boot with secure boot + TPM enabled against one boot with only the normal path if you still have a fallback generation.
    - If kernel module loading is the bottleneck, identify the exact unit/module first, then remove unused modules, defer optional services, or narrow hardware-specific imports.
    - If `niri-session` is the bottleneck, test launching `niri` directly versus `niri-session`, and inspect any wrapper scripts, portal startup, or user services it pulls in.
  - Collect diagnostics on the Nix machine:
    - `systemd-analyze time`
    - `systemd-analyze blame | head -n 30`
    - `systemd-analyze critical-chain`
    - `journalctl -b -p warning..err`
    - `journalctl -b | rg -i 'timed out|timeout|failed|slow|module|firmware|niri|greetd|tpm|crypt|luks|initrd'`
    - `systemd-analyze plot > boot.svg` and inspect longest chains visually
    - `journalctl -b -u greetd`
    - `journalctl --user -b | rg -i 'niri|dms|portal|dbus|xdg'`
    - `systemctl list-jobs`
    - `systemctl --failed`
    - `ls /run/current-system/sw/share/wayland-sessions`
    - `readlink -f /run/current-system/sw/share/wayland-sessions/*`
  - What to record:
    - Total firmware, loader, kernel, initrd, and userspace times from `systemd-analyze time`
    - Top 10 slowest units from `systemd-analyze blame`
    - Whether the slow path is before login, during greetd, or after the desktop appears
    - Whether duplicate session entries correspond to multiple `.desktop` files or symlinks
    - Whether the same slowdown reproduces every boot or only intermittently
- bash shell prompt appears twice when launching ghostty. (but only on launch, problem doesn't persist on continued use)

    ```shell
    nixos-config on  main [$!+]
    nixos-config on  main [$!+]
    bsh ❯ ERT --
    ```

  - Potential solutions:
    - Keep bash prompt initialization in one place only. Current repo change moves bash init ownership to Home Manager and enables Starship's bash integration there.
    - If duplication remains, inspect `blesh`, Ghostty shell integration, and any login-shell behavior from the terminal.
  - Verify on the Nix machine:
    - `exec bash` inside an existing shell and check whether prompt still appears once.
    - Launch Ghostty from desktop session and compare first prompt with a shell started from TTY.
    - `bash -lic 'typeset -p PROMPT_COMMAND'`
    - `bash -lic 'printf "%s\n" "$STARSHIP_SHELL" "$BLESH_VERSION"'`

- Millennium for steam isn't stable. The `steamwebhelper` can crash, leaving Steam unusable. (Occurrences = 1)
  - Potential solutions:
    - Reproduce once with Millennium disabled to separate Steam instability from Millennium instability.
    - Pin Millennium to a known-good revision or disable plugin/theme injection until root cause is clear.
    - Check whether Steam runtime versus native libraries changes crash frequency.
  - Verify on the Nix machine:
    - Reproduce with and without Millennium enabled.
    - Capture logs from Steam and `steamwebhelper` during the crash.
    - Note exact plugin/theme set loaded at crash time.
- Millennium's theme and plugin systems fail to download new themes and plugins.
  - Potential solutions:
    - Check whether plugin/theme download endpoints are blocked by sandboxing, TLS store issues, or changed upstream URLs.
    - Verify write permissions in Millennium's data directories.
    - Compare behavior with a clean Steam profile.
  - Verify on the Nix machine:
    - Capture network errors from Steam logs while attempting a download.
    - Confirm target directories are writable by the Steam user.
- Opening PDFs and other docs via yazi doesn't open the appropriate app
  - Zathura should be used for PDFs not Calibre
  - Potential solutions:
    - Keep MIME ownership in `xdg.mimeApps`, not in ad hoc application config.
    - Ensure PDF, CBZ, and CBR associations all point to Zathura so Calibre cannot win by broader reader registration.
    - If Yazi still ignores MIME defaults, inspect its opener configuration or whether it is invoking `mimeo`/`xdg-open` differently than expected.
  - Verify on the Nix machine:
    - `xdg-mime query default application/pdf`
    - `xdg-mime query default application/x-cbz`
    - `xdg-mime query default application/x-cbr`
    - `xdg-open some.pdf`
    - Open the same file from Yazi and compare behavior.
- Duplicated bash alias declaration in shell module (nixos and home-manager)
  - Potential solutions:
    - Keep user aliases only in Home Manager unless the alias is required system-wide.
  - Verify on the Nix machine:
    - `bash -lic 'alias ..'`
    - Confirm alias is still present after rebuild and only defined once in generated bash init.
- Duplicated declaration of default sops file in home and nixos module
  - Potential solutions:
    - Share one local binding for the secrets file path and reference it from both module scopes.
  - Verify on the Nix machine:
    - Rebuild and confirm no evaluation change beyond the refactor.
    - `nix eval .#nixosConfigurations.daedalus.config.sops.defaultSopsFile`
- Greetd shows multiple instances of the same session (2 hyprland, 2 niri, 2 hyprland with uwsm)
  - Potential solutions:
    - Most likely local source: multiple generated Wayland session `.desktop` files, with Hyprland's `withUWSM = true` in this repo being the strongest candidate for duplicate Hyprland entries.
    - `tuigreet` is probably only exposing what exists under the system `wayland-sessions` directory, not creating duplicates by itself.
    - Inspect generated session files under `wayland-sessions`; duplicates often come from both upstream session packages and extra wrappers such as UWSM.
    - For Hyprland specifically, `withUWSM = true` may produce additional session entries alongside the standard session.
    - Ensure greetd is not seeing both a wrapper session and the compositor's native session as separate choices unless that is intentional.
  - Verify on the Nix machine:
    - `ls -1 /run/current-system/sw/share/wayland-sessions`
    - `for f in /run/current-system/sw/share/wayland-sessions/*; do echo "== $f =="; sed -n '1,120p' "$f"; done`
    - Compare `Exec=` lines and identify duplicates that differ only by wrapper.
- BitWarden plugins has issues with accessing the vault. Normally, the plugins context menu launches a new window to enter the password, but after the update the new window is just blank. Unclear if this is a bitwarden or niri issue.
  - Potential solutions:
    - Separate application issue from compositor issue by reproducing in another session or another Wayland/Xwayland environment.
    - Check whether the auth window is blocked by portal, focus, or xdg-desktop-portal behavior.
    - Test whether the issue disappears with extensions/plugins disabled.
  - Verify on the Nix machine:
    - Capture app logs and `journalctl --user -b` while opening the auth window.
    - Reproduce once in Niri and once in another session if available.
- DMS has a slow startup, may be due to bad `niri-session` call
  - Potential solutions:
    - Time `dms` from a terminal inside the session and compare with launching it from the compositor binding.
    - Check whether the slowdown is DBus activation, portal startup, shader/font cache warmup, or a shell wrapper doing extra work.
    - If only the compositor binding is slow, compare direct binary launch against the current `spawn "dms" "ipc" "call" "spotlight" "toggle"` path.
  - Verify on the Nix machine:
    - `time dms ipc call spotlight toggle`
    - `journalctl --user -b | rg -i 'dms|dbus|portal'`
    - Launch once after login and once after caches are warm.

## Hyprland

- [ ] Switch layout to scrolling
- [ ] Disable trackpad
- [ ] Fix error: dispatcher `togglesplit` doesn't exist
- [ ] Fix window scaling

## Evaluation Warnings

```shell
evaluation warning: The xorg package set has been deprecated, 'xorg.libxcb' has been renamed to 'libxcb'
```

- Potential solutions:
  - Search local config and overlays for `xorg.libxcb` and replace with `pkgs.libxcb`.
  - If not present in this repo, identify which input or overlay still references it and either update or temporarily pin around the warning.
- Verify on the Nix machine:
  - `rg 'xorg\.libxcb' .`
  - `nix eval .#nixosConfigurations.daedalus.config.system.build.toplevel.drvPath --show-trace`
  - If warning persists with no local match, inspect referenced inputs or use `nix why-depends` on the affected package if you can isolate it.

## solaar-cli

```shell
bsh ❯ solaar-cli
Notification service is not available: Namespace Notify not available
rules cannot access modifier keys in Wayland, accessing process only works on GNOME with Solaar Gnome extension installed
Notification service is not available: Namespace Notify not available
Another Solaar process is already running so just expose its window
```

- Potential solutions:
  - Desktop notifications already work in-session via DMS/Quickshell, so this warning is more likely Solaar's own notification detection path failing than an actual absence of notifications.
  - This system uses `dbus-broker`, not `dbus-daemon`; that should normally be compatible, so treat broker as context to compare against rather than the primary suspect unless Solaar behaves differently under another bus implementation.
  - Compare Solaar's environment when launched interactively versus as a user service; the CLI may be missing DBus/session variables or a dependency Solaar expects for `Notify` introspection.
  - Modifier-key and process access limitations are expected on Wayland outside GNOME integration; treat those as platform constraints unless behavior is actually broken.
  - The final line suggests a second Solaar instance is already active; avoid running both daemonized and interactive copies unless intended.
- Verify on the Nix machine:
  - `pgrep -a solaar`
  - `systemctl --user status solaar`
  - `systemctl --user show-environment | rg 'DBUS|DISPLAY|WAYLAND|XDG_CURRENT_DESKTOP|XDG_RUNTIME_DIR'`
  - `env | rg 'DBUS|DISPLAY|WAYLAND|XDG_CURRENT_DESKTOP|XDG_RUNTIME_DIR'`
  - `busctl --user list | rg 'org.freedesktop.Notifications|solaar'`
  - Compare whether Solaar launched from terminal behaves differently from the user service.

## Build Errors
