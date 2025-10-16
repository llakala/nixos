{ lib }:

let
  inherit (lib) hasSuffix;
  inherit (lib.filesystem) listFilesRecursive;
  inherit (builtins) filter;
in
  folder: filter
    (path: hasSuffix "module.nix" (toString path))
    (listFilesRecursive folder)
