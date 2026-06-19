# If you're here to steal this, I recommend taking from the impl at
# https://github.com/llakala/synaptic-standard/blob/9365c4b7dc5c5d11685b0165bac88114c24df74b/demo/recursivelyImport.nix
# - that one is actively maintained to be as simple and readable as possible,
# while this is just my personal one
{ lib }:

let
  inherit (lib) concatMap hasPrefix hasSuffix;
  inherit (builtins) isPath filter readFileType;

  expandIfFolder = elem:
    if !isPath elem || readFileType elem != "directory"
      then [ elem ]
    else lib.filesystem.listFilesRecursive elem;

  # Don't forget toString to prevent copying paths to the store unnecessarily
  isNixFile = path:
    !hasPrefix "_" (baseNameOf (toString path))
    && hasSuffix ".nix" (toString path);

in
  list: filter
    # Filter out any path that doesn't look like `*.nix`.
    (elem: !isPath elem || isNixFile elem)
    # Expand any folder to all the files within it.
    (concatMap expandIfFolder list)
