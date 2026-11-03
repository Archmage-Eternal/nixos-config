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
   plain mango never starts that target.
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
