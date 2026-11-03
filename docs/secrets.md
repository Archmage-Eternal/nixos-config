# Secrets (sops-nix)

Secrets live encrypted in `secrets/secrets.yaml` (committed). sops-nix
decrypts them at login with your age key into `$XDG_RUNTIME_DIR/secrets.d`
(RAM, gone on logout). Module: `modules/nix/tools/sops [n]/sops.nix`.

## Bootstrap (once per machine / fresh clone)

The age key is NOT in the repo. Lose it and the secrets are unrecoverable, so
back up `~/.config/sops/age/keys.txt` somewhere safe and offline.

1. Enter the dev shell (provides `sops`): `nix develop`
2. Generate a key. No passphrase: sops-nix user services can't prompt.

   ```sh
   mkdir -p ~/.config/sops/age
   nix shell nixpkgs#age -c age-keygen -o ~/.config/sops/age/keys.txt
   ```

3. First time only: create `.sops.yaml` in the repo root with the public key
   (`age-keygen -y ~/.config/sops/age/keys.txt`):

   ```yaml
   keys:
     - &david age1...
   creation_rules:
     - path_regex: secrets/secrets\.yaml$
       key_groups:
         - age:
             - *david
   ```

4. First time only: `sops secrets/secrets.yaml`, add your first secret, save.
5. `git add .sops.yaml secrets` (flakes only see tracked files).

On an additional machine, restore the same `keys.txt` (step 2 is replaced by
copying it). For a new key instead: add its public key to `.sops.yaml`, then
re-encrypt with `sops updatekeys secrets/secrets.yaml`.

## Add a secret

1. Edit the file from the repo root: `sops secrets/secrets.yaml`. Nesting is
   allowed: `git: { token: ... }` is addressed as `"git/token"`.
2. Declare it in the HM module of the feature that uses it, not centrally:

   ```nix
   flake.modules.homeManager.foo = {config, ...}: {
     sops.secrets."git/token" = {};
   };
   ```

   Options: `mode` (default `0400`), `path` (custom location, `%r` expands to
   the runtime dir), `sopsFile` (use a different file than the default).

## Use a secret

`config.sops.secrets."git/token".path` is the runtime path of the decrypted
file (a string). It is only valid at runtime, never read it with Nix
(`builtins.readFile` would leak it into the store / fail at eval).

```nix
# a program that takes a file path
programs.ssh.matchBlocks."github.com".identityFile =
  config.sops.secrets."git/token".path;
```

To embed a secret in a generated config, use a template. The placeholder is
replaced at activation:

```nix
sops.templates."app.conf".content = ''
  token = ${config.sops.placeholder."git/token"}
'';
# path: config.sops.templates."app.conf".path
```

A systemd user service that reads a secret must order after the decrypt
service:

```nix
systemd.user.services.foo.Unit.After = ["sops-nix.service"];
```

## Notes

- Secrets are decrypted at login, not at `nixos-rebuild`.
- System-level secrets (NixOS module, `/run/secrets`) are not wired yet. When
  needed, import `inputs.sops-nix.nixosModules.sops` in a `nixos.sops` aspect
  and add the host SSH key (`ssh-to-age`) as a recipient in `.sops.yaml`.
