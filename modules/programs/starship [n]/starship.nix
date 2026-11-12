# Starship prompt (home-manager): the official Nerd Font Symbols preset, kept
# unmodified in nerd-font-symbols.toml (`starship preset nerd-font-symbols`,
# starship 1.26.0 as pinned by this flake; regenerate it when starship is
# updated, or unknown-key warnings appear), plus the shell
# indicator that shows bash/nu. Bash and nushell integration are on by default,
# and Stylix themes the palette, so neither is configured here.
{
  flake.modules.homeManager.starship = {lib, ...}: {
    programs.starship = {
      enable = true;
      settings = lib.recursiveUpdate (lib.importTOML ./nerd-font-symbols.toml) {
        shell.disabled = false;
      };
    };
  };
}
