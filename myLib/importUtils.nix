{ lib, myLib, ... }:

let

  internals = # Helper functions for internal use, not to be used outside this file
  {

    isNixFile = lib.hasSuffix ".nix";

    wrapIfNixFile = filepath: # Return a list containing only one element: the inputted filepath
      if internals.isNixFile filepath
        then lib.singleton filepath
      else [];

    nixFilesInFolder = dir: map # Return a list of nix files in the inputted folder. Non-recursive.
    ( file: dir + "/${file}" )
    (
      lib.attrNames
      (
        lib.filterAttrs
        ( # Only accepts .nix *files*, rejecting nested folders
          name: type:
          internals.isNixFile name
          && type == "regular"
        )
        ( builtins.readDir dir )
      )
    );


  };


  exports = # Export all files within this set
  {
    pathToFileList = path: # Wrapper around `wrapIfNixFile` and `nixFilesInFolder` that takes a path and automatically chooses the appropriate action for it. Returns a list of filepaths
      if lib.pathIsRegularFile path then internals.wrapIfNixFile path
      else if lib.pathIsDirectory path then internals.nixFilesInFolder path
      else [];

    importAll = paths: # Wrapper around pathToFileList that takes a full list of paths to evaluate
      lib.concatMap
        exports.pathToFileList
        paths;
  };
in
  exports # We don't pass the set with its name, we instead just pass all functions *within* the set