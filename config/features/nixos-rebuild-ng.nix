{ lib, pkgs-unstable, ... }:

{
  # Would add module, but can't, as there are stable and unstable conflicts
  # These include the module expecting `nixos-rebuild-ng` in `pkgs`, and the
  # new `replaceVarsWith` stuff not being in `pkgs` either.
  environment.systemPackages = lib.singleton
  (
    pkgs-unstable.nixos-rebuild-ng.override
    {
      nix = pkgs-unstable.lix;
      withNgSuffix = false;
      withReexec = false;
    }
  );
}
