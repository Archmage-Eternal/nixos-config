# Secure Boot via lanzaboote (NixOS). Extends `boot`; import it INSTEAD of `boot`.
#
# Fresh-install bootstrap:
#  1. Import `secureboot` in the host and rebuild.
#  2. Put the firmware in Setup Mode (firmware setup interface).
#  3. Reboot manually (autoReboot is off). Keys are generated and enrolled.
#  4. `sbctl status`  -> Secure Boot enabled.
#  5. `sbctl verify`  -> zero unsigned boot files.
#  6. Enroll TPM2 (below).
# Key generation allows unsigned boot files by default, so the first boot is
# not blocked by missing signatures. If `sbctl verify` still lists unsigned
# files after the first signed boot, do not rely on Secure Boot: fix them or
# switch the host back to `boot`.
# Microsoft keys stay enrolled so option ROMs (discrete NVIDIA GPU) still load.
# /var/lib/sbctl MUST be in every backup. Without it, new boot files cannot be
# signed with the enrolled keys.
#
# Migration (laptop with legacy setup, keys already in /var/lib/sbctl):
#  - Auto key options change nothing: keys exist, firmware not in Setup Mode.
#  - configurationLimit drops 10 -> 4. The next rebuild prunes boot entries
#    beyond the 4 newest; pruned generations are no longer bootable.
#  - Measured boot changes PCR 0/4/7 values. Legacy static PCR 7 enrollment
#    keeps working until replaced. Re-enroll with --tpm2-pcrlock to bind to
#    the pcrlock policy.
#  - Before re-enrolling: confirm the passphrase slot unlocks the device.
#    Wipe the legacy TPM2 token only after the new one unlocks at a later boot.
#  - After the first rebuild run `sbctl verify`. If files are unsigned, do not
#    reboot into it: fix, or roll back to the previous generation.
#
# TPM2 unlock (manual, once per LUKS device, after Secure Boot is on):
#  - `systemd-pcrlock is-supported` must print `yes`. systemd-pcrlock is
#    experimental upstream. If not `yes`, keep the passphrase only.
#  - systemd-cryptenroll --tpm2-device=auto --tpm2-with-pin=true \
#      --tpm2-pcrlock=/var/lib/systemd/pcrlock.json <device>
#  - Keep the passphrase keyslot on every device as the fallback.
#  - crypted-data: enrolled per device by the owner, otherwise passphrase.
{inputs, ...}: {
  flake.modules.nixos.secureboot = {
    lib,
    pkgs,
    ...
  }: {
    imports = [
      inputs.self.modules.nixos.boot
      inputs.lanzaboote.nixosModules.lanzaboote
    ];

    # lanzaboote replaces systemd-boot.
    boot.loader.systemd-boot.enable = lib.mkForce false;

    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
      # Must be <= 4 with measured boot. Equals the limit set in `boot`.
      configurationLimit = 4;
      autoGenerateKeys.enable = true;
      autoEnrollKeys.enable = true; # includeMicrosoftKeys defaults to true
      measuredBoot = {
        enable = true;
        pcrs = [0 4 7];
        # autoCryptenroll stays off: it accepts a single device only.
      };
    };

    security.tpm2.enable = true;
    environment.systemPackages = [pkgs.sbctl];
  };
}
