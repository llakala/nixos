{ options, inputs }:
let
  inherit (inputs.nixpkgs) lib;
in {
  credential."https://github.com".helper = "${lib.getExe options.drv} auth git-credential";
}
