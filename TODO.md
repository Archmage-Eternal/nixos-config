# To-do

## Cleanup

- [x] Remove Hyprland

---

## Installation

- [x] Install Niri
- [ ] Enable Protontricks and Winetricks
- [x] Install Waydroid _(???)_
- [ ] Install LilyPond
- [ ] Install pokeget-rs
- [ ] Create installation script
- [ ] Setup virtual machines
- [ ] Install ReShade or vkBasalt

---

## Configuration

### Shell & Terminal

- [ ] Set vi as $EDITOR
- [x] Refine `.bashrc`
  - [x] Add auto-completion to Bash
- [x] Check ligature functionality in terminal and/or Vim/Neovim
- [ ] Configure Ghostty
  - [ ] Add shaders to Ghostty
  - [x] Fix font configuration
- [x] Refine Starship prompt
  - [x] Show current shell in use
- [ ] Get protonhax working on nix
- [ ] Move all dev tools into devshells and remove them from system/home configuration
  - Devshells may also alow for nixCats overrides to be used for more target versions of the editor

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

### Desktop

- [ ] Configure home folders via XDG_HOME

### File & Media Management

- [ ] Configure window rules for height and width of Imv and MPV
- [ ] Configure dsearch's indexed directories

---

## Flakes & Home Manager

- [x] Update flake to add Home Manager support for Zen browser
