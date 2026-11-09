1. Understand mk-nixos.nix, and what it does. Seems like it could be sorted into a lib dir since it's a reused function; not a module/feature/aspect itself, or into hosts; since it's specific to hosts.
2. Create launch command string variables, along with flags, so that the var can just be passed to greetd/tuigreet as launchHyprland or launchMangoWM (var names pending review)
    - eg: launchHyprland = 'start-hyprland --flag1 --flag2' (just pseudo code)
    - Related: item 8. A registry of these commands could feed a generated tuigreet --sessions dir.
3. Decide on way to manage docs within the config
4. Leaner HM bundle for macOS/WSL machines. Current david bundle pulls
   Wayland compositor configs (hyprland, mangowm) that don't apply on non-NixOS
   desktops. Split a lean HM bundle (shell/editor/git) from the desktop bits.
   Low priority.
5. Standalone HM config (homeConfigurations.david) for non-NixOS Nix machines.
   Not literally "same module, zero code": needs a concrete pkgs/system, so
   ~5 lines wiring home-manager.lib.homeManagerConfiguration with a pinned system when such a machine exists. Low priority.
6. Formalized user declaration - a lib function to create users instead of
   hand-writing each. Low priority; will want it when building the home-lab config
7. Evaluate the `pipe-operators` experimental feature (|> language operator,
   seen in mightyiam's repo). Cost: it's a language-grammar change, so code
   using |> won't eval on stock Nix (tutorials won't use it, our code becomes
   non-portable). `lib.pipe` does the same thing today with no flag.
   Enable only if the syntax sugar proves worth the portability cost.
8. Duplicate Hyprland entries in the tuigreet menu. Look at the stock menu on
   the machine first, then decide.
   - Cause (verified by building services.displayManager.sessionData.desktops):
     the hyprland package itself ships both hyprland.desktop and
     hyprland-uwsm.desktop. programs.uwsm.waylandCompositors is empty, so
     nothing else adds them.
   - Candidate fix (tested in /tmp, works): pass tuigreet --sessions DIR, where
     DIR is the sessionData.desktops dir minus hyprland.desktop. Leaves
     hyprland-uwsm.desktop and mango.desktop.
   - Other candidate: generate the .desktop files from launch vars (item 2).
   - Unverified caveat: the uwsm entry runs `uwsm start -e -D Hyprland
     hyprland.desktop`, which refers to hyprland.desktop by ID. Hide the plain
     entry from the tuigreet menu dir only; do not remove it from
     services.displayManager.sessionPackages.
9. Evaluate mango under uwsm. Needs programs.uwsm.waylandCompositors.mango plus
   a `uwsm finalize` call in mango's autostart, or uwsm may hang waiting for
   the compositor. Worth it once HM systemd services tied to
   graphical-session.target (waybar, hypridle, ...) should run under mango;
   plain mango never starts that target. Already affected: caelestia and the
   polkit-agent (hyprpolkitagent) services, so neither runs under plain mango.
10. Launch keybind apps with `uwsm app --` so they run in their own systemd
    scopes instead of as children of the compositor. A plain exec from a
    keybind is still a child, even under uwsm.
11. When writing the boot/secureboot modules: set boot.consoleLogLevel = 0 and
    boot.initrd.verbose = false to keep kernel/initrd output off the tuigreet
    TTY (journalctl -b keeps the logs). useTextGreeter already covers systemd
    unit output. Also decide whether boot and secureboot need to be two modules.
12. Re-evaluate secureboot decisions once the daily-driver laptop is accessible
    (spec: .kiro/specs/secureboot-module). Decide with real hardware state:
    - autoEnrollKeys (keep on, or enroll manually with sbctl)
    - measured boot (pcrs [0 4 7], configurationLimit 4, systemd-pcrlock
      is-supported must print yes; pcrlock is experimental)
    - TPM2 LUKS enrollment (crypted-system / crypted-data via
      systemd-cryptenroll --tpm2-pcrlock) and the matching
      boot.initrd.luks.devices.<name>.crypttabExtraOpts = ["tpm2-device=auto"]
    - Hardware-only checks: Setup Mode bootstrap, sbctl status/verify, quiet
      greeter TTY, passphrase fallback, migration from legacy keys, boot time
      (3 cold boots, systemd-analyze).
13. Impermanence + sops-nix (only if/when impermanence is adopted). The secrets
    file is safe (in /nix store); the age key is not: the HM module reads
    ~/.config/sops/age/keys.txt, which a wiped $HOME loses, so sops-nix.service
    fails at login and nothing decrypts. Options:
    - Point sops.age.keyFile at the persisted file directly, e.g.
      /persist/home/david/.config/sops/age/keys.txt (sops-nix README
      recommends this). Prefer it over bind-mounting via home.persistence:
      user-level mounts can race with sops-nix.service at login.
    - Then the sops CLI no longer finds the key by default. Set
      SOPS_AGE_KEY_FILE to the same path (home.sessionVariables, and the dev
      shell), sharing one let-bound path with age.keyFile.
    - Or use age.sshKeyPaths with a persisted SSH key (host key
      /etc/ssh/ssh_host_ed25519_key for system secrets, a user key for HM);
      public half via ssh-to-age in .sops.yaml. Avoids a separate key file;
      fits system-level secrets (nixos.sops aspect) best.
    - Back up the key regardless; losing it makes secrets unrecoverable.
    - Update docs/secrets.md bootstrap step 2 with the persisted location.
14. Controller udev rules (hardware.steam-hardware.enable, DualSense/Xbox pad
    permissions) currently only arrive via programs.steam.enable. If a
    gaming-desktop host ever drops Steam, controllers (wine
    games) lose udev access with no obvious error. Split into its own aspect
    if/when that happens; not worth it while every gaming host runs Steam.
15. Millennium (steam client mod) is wired as its own aspect (gaming/millennium.nix
    + millennium input) but commented out of the gaming-desktop bundle. Its
    build runs `bun install` to fetch npm deps, which fails behind a
    TLS-intercepting proxy (SELF_SIGNED_CERT_IN_CHAIN) and has no binary cache.
    Re-enable the import and build on a network without the proxy. If it still
    fails, override the derivation to pass the CA bundle to bun, or drop it.
16. Hyprcursor cursors (investigate later). Today the cursor is XCursor
    (Bibata-Modern-Ice) via stylix.cursor + home.pointerCursor; the
    HYPRCURSOR_* env set by pointerCursor.hyprcursor does nothing for an
    XCursor-only theme. Evaluate switching to a hyprcursor-format theme:
    - Benefits to check: vector (SVG) cursors that stay sharp at any scale or
      per-monitor scale; fewer scaling artifacts than bitmap XCursor.
    - Drawbacks to check: Hyprland-only. mangowm (wlroots-based) and
      XWayland/GTK/Qt apps still use XCursor, so the cursor would differ
      between compositors unless the XCursor theme stays installed alongside.
      Small theme ecosystem and nixpkgs availability; confirm the fallback
      behavior when a hyprcursor theme is missing.
    - Compatibility: keep XCursor as the baseline for mango and everything
      non-Hyprland; hyprcursor would be an additive layer, not a replacement.
    - The hyprcursor flag was dropped. A hyprcursor theme also needs
      HYPRCURSOR_THEME/HYPRCURSOR_SIZE (home.pointerCursor.hyprcursor.enable)
      on top of the stylix cursor.
17. Hardware follow-ups on daedalus (check on the machine):
    - asusd vs power-profiles-daemon: ppd is off. asus-linux docs tie profile
      switching to ppd, but an asusctl issue reports ppd resetting EPP. Test
      `asusctl profile` and the desktop power toggle before enabling ppd.
    - supergfxd with nvidia prime offload + finegrained power management: confirm
      Hybrid mode behaves, and that Integrated mode isn't used by accident.
    - Logitech: only Solaar is set up. Add programs.solaar.userService.enable to
      apply settings at login (rides graphical-session.target, see item 9).
      services.ratbagd (+ Piper) only matters for gaming mice with onboard
      profiles; hardware.keyboard.qmk only for flashing QMK keyboards. Add if
      the hardware needs them.
    - File pickers: the GTK portal is installed and Hyprland ships its portal
      config; confirm the file chooser works in Zen under both compositors.
    - Lock/idle: Caelestia ships its own lock screen and idle monitors; confirm
      they lock on lid close/suspend before relying on them.
18. Stylix now themes everything with a target (autoEnable = true; opt out per
    app with stylix.targets.<app>.enable = false). Things to check on the machine:
    - Caelestia has no stylix target (Qt Quick shell with its own colour scheme),
      so the shell won't match the rest. Align its scheme by hand or via
      programs.caelestia.settings.
    - The qt target sets QT_QPA_PLATFORMTHEME=qt5ct and kvantum; it may touch
      Caelestia (Qt). If the shell looks off, override those in the shell's
      programs.caelestia.systemd.environment.
    - Font sizes were restored from the legacy config (desktop 12, applications
      15, terminal 17, popups 17); adjust if text is too large.
    - New apps are themed automatically; some targets warn when their app isn't
      installed (rofi did, now disabled). Disable noisy ones as they show up.
    - No wallpaper is set (stylix.image null); Caelestia manages wallpaper.
