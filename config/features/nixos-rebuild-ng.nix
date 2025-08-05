{ lib, pkgs, ... }:

{
  # Module doesn't seem to support a custom nix package yet. It does reuse the
  # one from `nix.settings`, which might work, but that'll have to be
  # investigated another time. For now, this shadows the other package and works
  # fine.
  environment.systemPackages = lib.singleton
  (
    pkgs.nixos-rebuild-ng.override
    {
      nix = pkgs.lix;
      withNgSuffix = false;
      withReexec = false;
    }
  );
}
