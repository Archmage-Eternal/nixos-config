# Issues

## General

- Startup time is slow in general after adding secure boot and TPM2 unlock
  - Additional slowdowns occur because of a start job that occasionally takes a lot of time to load kernel modules.
  - Additional slowdowns are caused because of how the `niri-session` is called
- bash shell prompt appears twice when launching ghostty. (but only on launch, problem doesn't persist on continued use)

    ```shell
    nixos-config on  main [$!+]
    nixos-config on  main [$!+]
    bsh ❯ ERT --
    ```

- Millennium for steam isn't stable. The `steamwebhelper` can crash, leaving Steam unusable. (Occurrences = 1)
- Millennium's theme and plugin systems fail to download new themes and plugins.
- Opening PDFs and other docs via yazi doesn't open the appropriate app
  - Zathura should be used for PDFs not Calibre
- Duplicated bash alias declaration in shell module (nixos and home-manager)
- Duplicated declaration of default sops file in home and nixos module
- Greetd shows multiple instances of the same session (2 hyprland, 2 niri, 2 hyprland with uwsm)
- BitWarden plugins has issues with accessing the vault. Normally, the plugins context menu launches a new window to enter the password, but after the update the new window is just blank. Unclear if this is a bitwarden or niri issue.
- DMS has a slow startup, may be due to bad `niri-session` call

## Hyprland

- [ ] Switch layout to scrolling
- [ ] Disable trackpad
- [ ] Fix error: dispatcher `togglesplit` doesn't exist
- [ ] Fix window scaling

## Evaluation Warnings

```shell
evaluation warning: The xorg package set has been deprecated, 'xorg.libxcb' has been renamed to 'libxcb'
```

## solaar-cli

```shell
bsh ❯ solaar-cli
Notification service is not available: Namespace Notify not available
rules cannot access modifier keys in Wayland, accessing process only works on GNOME with Solaar Gnome extension installed
Notification service is not available: Namespace Notify not available
Another Solaar process is already running so just expose its window
```

## Build Errors
