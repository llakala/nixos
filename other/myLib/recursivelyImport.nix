{ lib }:

let
  inherit (builtins)
    attrNames
    concatMap
    isPath
    readDir
    readFileType
    ;

  hasUnderscorePrefix = lib.hasPrefix "_";
  hasNixSuffix = lib.hasSuffix ".nix";

  listNixFilesRecursive =
    folder:
    let
      contents = readDir folder;
    in
    concatMap (
      name:
      if contents.${name} == "directory" then
        listNixFilesRecursive (folder + "/${name}")
      else if hasNixSuffix name && !hasUnderscorePrefix (baseNameOf name) then
        [ (folder + "/${name}") ]
      else
        [ ]
    ) (attrNames contents);
in
concatMap (
  elem:
  if !isPath elem then
    [ ]
  else if readFileType elem != "directory" then
    [ elem ]
  else
    listNixFilesRecursive elem
)
