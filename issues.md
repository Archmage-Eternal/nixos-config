# Issues

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

Check if hyprland cache's been added

```nix
error: Cannot build '/nix/store/j0lz5fzhyk1rliy7w7smhgzw676mhv4n-rust-src-1.78.0-x86_64-unknown-linux-gnu.drv'.
       Reason: builder failed with exit code 1.
       Output paths:
         /nix/store/mx62qdlwyplc5b4l1h6w6zc391r0fdwj-rust-src-1.78.0-x86_64-unknown-linux-gnu
       Last 3 log lines:
       > Running phase: unpackPhase
       > unpacking source archive /nix/store/w3njwdqx2pfb7nlnkzafnz0whh7i5kyc-unknown
       > do not know how to unpack source archive /nix/store/w3njwdqx2pfb7nlnkzafnz0whh7i5kyc-unknown
       For full logs, run:
         nix log /nix/store/j0lz5fzhyk1rliy7w7smhgzw676mhv4n-rust-src-1.78.0-x86_64-unknown-linux-gnu.drv
error: Cannot build '/nix/store/rvmi8iwrh12y244pjp71k4ckkh47ixfx-rust-default-1.78.0.drv'.
       Reason: 1 dependency failed.
       Output paths:
         /nix/store/j3ahx98cdq0knvz92qnd186c48vc949d-rust-default-1.78.0
error: Build failed due to failed dependency
error: Cannot build '/nix/store/gjc0vbsz28v0ngnzi0zafs5wfzyvwgn0-lanzaboote-stub-0.4.2.drv'.
       Reason: 1 dependency failed.
       Output paths:
         /nix/store/7alc4gsivjpkclk53nkaa592hd664qsk-lanzaboote-stub-0.4.2
error: Cannot build '/nix/store/ry48axpk06sf2fksni8a88wy9fghbd75-lanzaboote-stub-deps-0.4.2.drv'.
       Reason: 1 dependency failed.
       Output paths:
         /nix/store/h37gw7mzir7zabx5w8xw4k0i5qqwsr32-lanzaboote-stub-deps-0.4.2
error: Cannot build '/nix/store/25rspd8qarv35zd4xn76fm308p03xswy-lzbt-systemd-0.4.2.drv'.
       Reason: 1 dependency failed.
       Output paths:
         /nix/store/g1nrsh9ganqmp78zgbwjb11z59z66npn-lzbt-systemd-0.4.2
error: Cannot build '/nix/store/sy2f1fp6d02c7ra89l7x7ya9pzz41l41-lzbt-systemd-deps-0.4.2.drv'.
       Reason: 1 dependency failed.
       Output paths:
         /nix/store/7im26gp9p63jwbfz4kr0mpvvb7axpxgm-lzbt-systemd-deps-0.4.2
copying path '/nix/store/mcxv9rdclij44xs90x4gkp5qnh87fcf5-lttng-ust-2.14.0-bin' from 'https://cache.nixos.org'
copying path '/nix/store/mr3j3l26licbf1m138217vqkddvqvh4q-mariadb-connector-odbc-3.2.6' from 'https://cache.nixos.org'
error: Cannot build '/nix/store/xfz67ayh3hg6ha8zkw9lnk4srcw9rqx3-lzbt.drv'.
       Reason: 1 dependency failed.
       Output paths:
         /nix/store/fij3nvjcsyglix7gmwwzvq06xmigzmz4-lzbt
error: Cannot build '/nix/store/wh1pymnn68lyhnkg5qjjcwwadkm5vxzc-bootinstall.drv'.
       Reason: 1 dependency failed.
       Output paths:
         /nix/store/f3x63dcmn2s9z9dgl8x3jmsd9jznm3md-bootinstall
error: Cannot build '/nix/store/x49zb9kh68xw2nkil7r8pn6a77zq8slb-nixos-system-laptop-26.05.20260414.4bd9165.drv'.
       Reason: 1 dependency failed.
       Output paths:
         /nix/store/zasby16a91sv08l7khl32xxa0cjlhdzw-nixos-system-laptop-26.05.20260414.4bd9165
┏━ 10 Errors:
 ⋮
┃ error: Cannot build '/nix/store/j0lz5fzhyk1rliy7w7smhgzw676mhv4n-rust-src-1.78.0-x86_64-unknown-linux-gnu.drv'.
┃        Reason: builder failed with exit code 1.
┃        Output paths:
┃          /nix/store/mx62qdlwyplc5b4l1h6w6zc391r0fdwj-rust-src-1.78.0-x86_64-unknown-linux-gnu
┃        Last 3 log lines:
┃        > Running phase: unpackPhase
┃        > unpacking source archive /nix/store/w3njwdqx2pfb7nlnkzafnz0whh7i5kyc-unknown
┃        > do not know how to unpack source archive /nix/store/w3njwdqx2pfb7nlnkzafnz0whh7i5kyc-unknown
┃        For full logs, run:
┃          nix log /nix/store/j0lz5fzhyk1rliy7w7smhgzw676mhv4n-rust-src-1.78.0-x86_64-unknown-linux-gnu.drv
┣━ Dependency Graph:
┃          ┌─ ⏸ lzbt-systemd-deps-0.4.2 waiting for 1 ⏵ 69 ↓ ⏸
┃       ┌─ ⏸ lzbt-systemd-0.4.2
┃       │  ┌─ ⏸ lanzaboote-stub-deps-0.4.2 waiting for 1 ⏵ 22 ↓ ⏸
┃       │  │     ┌─ ⏸ rustc-1.78.0-x86_64-unknown-linux-gnu
┃       │  │  ┌─ ⏸ clippy-preview-1.78.0-x86_64-unknown-linux-gnu
┃       │  │  ├─ ⏵ rust-src-1.78.0-x86_64-unknown-linux-gnu (unpackPhase) ⏱ 17s
┃       │  ├─ ⏸ rust-default-1.78.0
┃       ├─ ⏸ lanzaboote-stub-0.4.2
┃    ┌─ ⏸ lzbt
┃ ┌─ ⏸ bootinstall
┃ ⏸ nixos-system-laptop-26.05.20260414.4bd9165
┣━━━ Builds             │ Downloads           │ Host
┃    ⏵ 1 │ ✔ 91 │       │     │       │       │ localhost
┃        │      │       │     │ ↓  95 │       │ [1]: https://cache.nixos.org
┃        │      │       │     │ ↓  19 │       │ [2]: https://nix-community.cachix.org
┗━ ∑ ⏵ 1 │ ✔ 91 │ ⏸ 138 │ ↓ 0 │ ↓ 114 │ ⏸ 134 │ ⚠ Exited with 10 errors reported by nix at 19:00:38 after 1m17s
Error:
   0: Failed to build configuration
   1: Command exited with status Exited(1)

Location:
   src/commands.rs:880
[ble: exit 1][ble: elapsed 77.255s (CPU 47.6%)] nh os test .
```
