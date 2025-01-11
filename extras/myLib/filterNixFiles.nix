{ lib }:

let
  internals.filterFile = path:
    assert lib.assertMsg (lib.pathIsRegularFile path)
      "Encountered subfolder ${path}! You must not have resolved all subfolders before filtering, you silly goose.";
    if lib.hasSuffix ".nix" path
      then lib.singleton path
      else []; # Reject non-nix files.
in
  inputs: lib.concatMap # Return the inputted list, but any file that isn't a nix file is filtered out
  (
    input:
    if builtins.isPath input
      then internals.filterFile input
    else lib.singleton input # Return input unchanged if it's not a filepath, wrapped in a list for concatMap. Folders will be returned unchanged, that's out of the concern of this function
  )
  inputs