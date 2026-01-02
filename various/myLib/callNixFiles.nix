{ lib }:
folder: args:
let
  inherit (lib) foldlAttrs;
  inherit (builtins) substring stringLength match readDir;
  callPackage = lib.callPackageWith args;
in
foldlAttrs (
  acc: path: type:
  if type == "regular" && match ".*\\.nix" path == [ ] then
    acc
    // {
      ${substring 0 (stringLength path - 4) path} = callPackage "${toString folder}/${path}" {};
    }
  else if type == "directory" then
    acc
    // {
      ${path} = callPackage "${toString folder}/${path}/default.nix" {};
    }
  else
    acc
) { } (readDir folder)
