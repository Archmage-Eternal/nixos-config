# protonhax (home-manager): run tools inside a running Proton game's prefix.
# Steam launch option: `protonhax init %command%`; then `protonhax run <appid> <cmd>`.
# Inlined from github:linusfri/protonhax-nix (not in nixpkgs; ~25 lines, so no
# extra flake input). The script's shebang is prefixed with steam-run so it
# runs inside the Steam FHS runtime.
{
  flake.modules.homeManager.protonhax = {pkgs, ...}: {
    home.packages = [
      (pkgs.stdenv.mkDerivation rec {
        pname = "protonhax";
        version = "1.0.5";
        src = pkgs.fetchFromGitHub {
          owner = "jcnils";
          repo = pname;
          rev = version;
          hash = "sha256-5G4MCWuaF/adSc9kpW/4oDWFFRpviTKMXYAuT2sFf9w=";
        };
        installPhase = ''
          install -Dm755 protonhax $out/bin/protonhax
        '';
        postFixup = ''
          sed -i '1s|^#!|#!${pkgs.lib.getExe pkgs.steam-run} |' $out/bin/protonhax
        '';
        meta = {
          description = "Run tools inside a Proton game's prefix";
          homepage = "https://github.com/jcnils/protonhax";
          mainProgram = "protonhax";
        };
      })
    ];
  };
}
