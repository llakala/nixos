{ inputs, lib, pkgs-unstable, ... }:
{
  disabledModules = lib.singleton "installer/tools/tools.nix";

  imports = lib.singleton
    "${inputs.nixpkgs-unstable}/nixos/modules/installer/tools/tools.nix";

  # Can't enable right now, because module expects to find nixos-rebuild-ng in `pkgs`
  # Unsure whether I should make an issue for this - I have the weird case of using
  # stable primarily, but still wanting unstable features sometimes.
  system.rebuild.enableNg = false;

  environment.systemPackages = lib.singleton pkgs-unstable.nixos-rebuild-ng;
}