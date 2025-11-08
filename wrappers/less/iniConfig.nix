{ options, inputs }:
let
  inherit (inputs.nixpkgs) lib;
in {
  core.pager = lib.getExe options.drv;
}
