1. Understand mk-nixos.nix, and what it does. Seems like it could be sorted into a lib dir since it's a reused function; not a module/feature/aspect itself, or into hosts; since it's specific to hosts.
2. Add greetd + tuigreet. 
3. Create launch command string variables, along with flags, so that the var can just be passed to greetd/tuigreet as launchHyprland or launchMangoWM (var names pending review)
    - eg: launchHyprland = 'start-hyprland --flag1 --flag2' (just pseudo code)
4. Decide on way to manage docs within the config
5. Leaner HM bundle for macOS/WSL machines. Current david bundle pulls
   Wayland compositor configs (hyprland, mangowm) that don't apply on non-NixOS
   desktops. Split a lean HM bundle (shell/editor/git) from the desktop bits.
   Low priority.
6. Standalone HM config (homeConfigurations.david) for non-NixOS Nix machines.
   Not literally "same module, zero code": needs a concrete pkgs/system, so
   ~5 lines wiring home-manager.lib.homeManagerConfiguration with a pinned
   system when such a machine exists. Low priority.
7. Formalized user declaration - a lib function to create users instead of
   hand-writing each. Low priority; will want it when building the home-lab
   config
8. Evaluate the `pipe-operators` experimental feature (|> language operator,
   seen in mightyiam's repo). Cost: it's a language-grammar change, so code
   using |> won't eval on stock Nix (tutorials won't use it, our code becomes
   non-portable). `lib.pipe` does the same thing today with no flag.
   Enable only if the syntax sugar proves worth the portability cost.
