{ lib, myLib, ... }:

let

  internals = # Helper functions for internal use, not to be used outside this file
  {

    isNixFile = lib.hasSuffix ".nix";

    wrapIfNixFile = filepath: # Return a list containing only one element: the inputted filepath
      if internals.isNixFile filepath
        then lib.singleton filepath
      else []; # Disinclude the file if it's not a nix file

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
    pathToFileList = input: # Wrapper around `wrapIfNixFile` and `nixFilesInFolder` that takes a path and chooses the appropriate action. Returns a list of filepaths
      if builtins.isPath input then
        if lib.pathIsRegularFile input then internals.wrapIfNixFile input
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
