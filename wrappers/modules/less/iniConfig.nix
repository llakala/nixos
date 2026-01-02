{ options, inputs }:
let
  inherit (inputs.nixpkgs) lib;
  finalWrapper = options {};
in {
  core.pager = lib.getExe finalWrapper;
}
