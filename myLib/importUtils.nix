{ lib, myLib, ... }:

let # Functions for internal use, not exporting

  internals =
  {

    isNixFile = lib.hasSuffix ".nix";


    importNixFile = filepath: # Return a list containing only one element: the inputted filepath
      if internals.isNixFile filepath
        then lib.singleton filepath
      else [];

    importNixFolder = dir: builtins.map # Return a list of nix files in the corresponding folder
    ( file: dir + "/${file}" )
    (
      builtins.attrNames
      (
        lib.filterAttrs
        (
          name: type:
          lib.hasSuffix ".nix" name
          && type == "regular"
        )
        ( builtins.readDir dir )
      )
    );


  };


  exports = # Export all files within this set
  {
    importAny = path: # Return a list containing files to be imported
      if lib.pathIsDirectory path then internals.importNixFolder path
      else if lib.pathIsRegularFile path then internals.importNixFile path
      else [];

    importAll = paths: # Combine lists of paths generated via importAny
      builtins.concatMap
        exports.importAny
        paths;
  };
in
  exports # We don't pass the set with its name, we instead just pass all functions *within* the set