{ lib, myLib, ... }:

let # Functions for internal use, not exporting

  internals =
  {
    isNixFile = lib.hasSuffix ".nix";

    
    importNixFile = filepath:
      if builtins.pathExists filepath && internals.isNixFile filepath
        then [ filepath ]
      else [];

    importNixFolder = dir: # Import all nix files within a folder
      if !builtins.pathExists dir || builtins.readDir dir == {}
        then [] # Exit early if directory doesn't exist, or is empty
      else lib.mapAttrsToList
      (file: _: dir + "/${file}")
      (lib.filterAttrs
        (file: _: internals.isNixFile file)
        (builtins.readDir dir)
      );
  };


  exports = # Export all files within this set
  {
    importAny = path: # Imports either a file or a folder of nix files
      if !builtins.pathExists path then [] # Exit early if path is invalid
      else if lib.pathIsDirectory path then internals.importNixFolder path
      else internals.importNixFile path;

    importAll = dirs:
      lib.concatLists
      (map exports.importAny dirs);
  };
in
  exports # We don't pass the set with its name, we instead just pass all functions *within* the set