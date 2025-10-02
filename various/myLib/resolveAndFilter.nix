{ lib }:

let
  handlePath = path:
    if lib.isPath path && lib.pathIsDirectory path
      then lib.filesystem.listFilesRecursive path
    else
      # Handles both modules and single files
      lib.singleton path;

  handlePaths = paths:
    builtins.concatMap
    handlePath paths;

  filterNixFiles = paths:
    builtins.filter
    # After being handled, we either get something that's not a path (typically
    # a module), or a path that ends with ".nix"
    (path: !builtins.isPath path || lib.hasSuffix ".nix" path)
    (handlePaths paths);
in
  filterNixFiles
