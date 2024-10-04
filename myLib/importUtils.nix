{ lib, myLib, ... }:

let

  internals = # Helper functions for internal use, not to be used outside this file
  {

    isNixFile = lib.hasSuffix ".nix";

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
    pathToFileList = input: # Take a given input and
      if builtins.isPath input then
        if internals.isNixFile input then lib.singleton input
        else if lib.pathIsDirectory input then internals.nixFilesInFolder input
        else [] # It's a path, but not a file or a directory? Astonishing
      else lib.singleton input; # Return input unchanged if it's not a path. Makes attribute sets work

    importAll = paths: # Wrapper around pathToFileList that takes a full list of values to evaluate
      lib.concatMap
        exports.pathToFileList
        paths;
  };
in
  exports # We don't pass the set with its name, we instead just pass all functions *within* the set
