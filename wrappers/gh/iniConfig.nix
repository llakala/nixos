{ options, inputs }:
let
  inherit (inputs.nixpkgs) lib;
  finalWrapper = options {};
in {
  credential."https://github.com".helper = "${lib.getExe finalWrapper} auth git-credential";
}
