# To-do

## Installation

- [ ] Enable Protontricks and Winetricks
- [ ] Install LilyPond
- [ ] Install pokeget-rs
- [ ] Create installation script
- [ ] Setup virtual machines
- [ ] Install ReShade or vkBasalt
- [ ] Install shadps4 (Bloodborne baby)
- [ ] Add NUR usage

## Configuration

- [ ] Create options in nvidia module to define PCI addresses for GPUs
- [ ] Investigate setting config.allowUnfree (may have overlap with new flake-parts way of doing it)
- [ ] Duplicated bash alias decleration in shell module (nixos and home-manager)
- [ ] Duplicated delcaration of default sops file in home and nixos module
- [ ] Split xdg-mime config from desktop config
- [ ] Screen outputs config for niri should be more generic. Extract host specific settings.
- [ ] Alter keybinds to launch terminal and file explorer instead of specific ones like ghostty, or yazi. Also make option to define terminal or file explorer for modularity
  - Example for terminal from mightyiam:
  - default.nix
    ```nix
    { lib, withSystem, ... }:
    {
      flake.modules.homeManager.gui =
        hmArgs@{ pkgs, ... }:
        let
          hyprcwd = withSystem pkgs.stdenv.hostPlatform.system (psArgs: psArgs.config.packages.hyprcwd);
        in
        {
          options.terminal = {
            path = lib.mkOption {
              type = lib.types.path;
              default = null;
            };
            desktopFileId = lib.mkOption {
              type = lib.types.singleLineStr;
            };
          };
          config = {
            xdg.terminal-exec = {
              enable = true;
              settings.default = [ hmArgs.config.terminal.desktopFileId ];
            };
            wayland.windowManager = {
              hyprland.settings.bind = [
                "SUPER, Return, exec, ${hmArgs.config.terminal.path}"
                "SUPER+SHIFT, Return, exec, ${hmArgs.config.terminal.path} --working-directory `${lib.getExe hyprcwd}`"
              ];
            };
          };
        };
    }
    ```
  - alacritty.nix 
    ``` nix
    { lib, ... }:
    {
      flake.modules.homeManager.gui = hmArgs: {
        terminal = {
          path = lib.getExe hmArgs.config.programs.alacritty.package;
          desktopFileId = "Alacritty.desktop";
        };
    
        programs.alacritty = {
          enable = true;
          settings = {
            general.live_config_reload = true;
            window = {
              decorations = "none";
              dynamic_title = true;
              title = "Terminal";
            };
            bell = {
              # https://github.com/danth/stylix/discussions/1207
              # ideally this would be some stylix color theme color
              color = "#000000";
              duration = 200;
            };
          };
        };
      };
    }
    ```
- [ ] Do the same as above to define window manager and make the niri and hyprland (hyprland module is currently deleted) modules define them when imported 

### Shell & Terminal

- [ ] Set vi/nvim/nixCats-minimal as $EDITOR
- [x] Refine `.bashrc`
  - [x] Add auto-completion to Bash
- [x] Check ligature functionality in terminal and/or Vim/Neovim
- [ ] Configure Ghostty
  - [ ] Add shaders to Ghostty
  - [x] Fix font configuration
- [x] Refine Starship prompt
  - [x] Show current shell in use
  - [ ] Minimized config, it is overly bloated
- [ ] Get protonhax working on nix
- [ ] Move all dev tools into devshells and remove them from system/home configuration
  - Devshells may also allow for nixCats overrides to be used for more target versions of the editor

### Applications

- [ ] Declaratively configure Zen browser's plugins _(and theme??)_
  - [ ] Figure out how stylix and zen-hm module profile declaration interacts
- [ ] Configure Yazi and add relevant plugins if needed
- [ ] Configure Fastfetch (or make custom fetch script) and add Pokémon sprites
- [ ] Configure MangoHud
- [ ] Automate NVIDIA libraries setup
- [ ] Automate Zotero Connector and Better BibTeX setup
- [ ] Make `nb` configuration declaritive

### Niri

- [ ] Add keybinds to Niri
  - Lock
  - Clipboard history
  - Power menu
  - Calendar / Main menu
  - Media keys _(volume roller might be tricky)_
- [ ] Configure screenshot directory (`$XDG_PICTURES_HOME`)
- [ ] Change window border thickness and window gap size

### Desktop

- [ ] Configure home folders via XDG_HOME

### File & Media Management

- [ ] Configure window rules for height and width of Imv and MPV
- [ ] Configure `dsearch`'s indexed directories
