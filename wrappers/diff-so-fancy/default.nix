{ adios }:

{
  name = "diff-so-fancy";

  inputs = {
    mkWrapper.path = "/mkWrapper";
    nixpkgs.path = "/nixpkgs";
    git.path = "/git";
    less.path = "/less";
  };

  mutations = {
    "/git" = {
      iniConfig = { inputs }: import ./iniConfig.nix { inherit inputs; };
    };
  };

  impl =
    { inputs }:
    let
      inherit (inputs.nixpkgs) pkgs;
    in
    inputs.mkWrapper {
      package = pkgs.diff-so-fancy;
      environment = {
        GIT_CONFIG_GLOBAL = "${inputs.git.configDir}/git/config";
      };
    };
}
