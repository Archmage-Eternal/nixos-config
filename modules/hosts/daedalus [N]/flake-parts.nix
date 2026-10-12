# Build the daedalus nixosConfiguration from its host aspect.
{inputs, ...}: {
  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" "daedalus";
}
