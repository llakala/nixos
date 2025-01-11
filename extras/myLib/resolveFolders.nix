{ lib }:

let
  internals.extractFiles = dir: map # Return a list of files within `dir`
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

  internals.extractFolders = dir: map # Return a list of subfolders within `dir`
  (folder: dir + "/${folder}")
  (
    lib.attrNames
    (
      lib.filterAttrs
      (
        name: type:
        type == "directory" # Only accept subfolders
      )
      ( builtins.readDir dir )
    )
  );

  internals.extractFilesAndStubs = dir: # Return files within a folder, recursing one level deep to subfolders only
  let
    topFiles = internals.extractFiles dir; # List of files at the top-level of `dir`
    subfolders = internals.extractFolders dir; # List of subfolders at the top-level of `dir`
    subfolderFiles = lib.concatMap internals.extractFiles subfolders; # List of files at the top-level of each subfolder
  in
    topFiles ++ subfolderFiles;

in
  inputs: lib.concatMap # Take a list and send any folders to extractFolder to be extracted. Return an identical list with the folders extracted
  (
    input:
    if builtins.isPath input && lib.pathIsDirectory input
      then internals.extractFilesAndStubs input
    else lib.singleton input # Return input unchanged if it's not a folder, wrapped in a list for concatMap
  )
  inputs
