{ lib, myLib, ... }:

let
  internals.extractFolder = dir: map # Return a list of files in the inputted folder
  ( file: dir + "/${file}" )
  (
    lib.attrNames
    (
      lib.filterAttrs
      (
        name: type:
        type == "regular" # Reject subfolders, recursion is for cowards with an unorganized file tree
      )
      ( builtins.readDir dir )
    )
  );


in
  inputs: lib.concatMap # Take a list and send any folders to extractFolder to be extracted. Return an identical list with the folders extracted
  (
    input:
    if builtins.isPath input && lib.pathIsDirectory input
      then internals.extractFolder input
    else lib.singleton input # Return input unchanged if it's not a folder, wrapped in a list for concatMap
  )
  inputs
