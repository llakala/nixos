{ adios }:
let
  inherit (adios) types;
in {
  name = "git";

  inputs = {
    mkWrapper.path = "/mkWrapper";
    nixpkgs.path = "/nixpkgs";
  };

  mutations."/fish".abbreviations = _: import ./abbreviations.nix;

  options = {
    ignoreFile = {
      type = types.path;
      default = ./ignore;
    };
    iniConfig = {
      mutators = [ "/gh" "/less" "/diff-so-fancy" ];
      type = types.attrs;
      mutatorType = types.attrs;
      mergeFunc =
        { mutators, inputs }:
        adios.lib.mergeFuncs.deeplyMergeAttrs {
          mutators = mutators // {
            settings = import ./settings.nix { inherit inputs; };
          };
        };
    };

    configDir = {
      type = types.derivation;
      defaultFunc =
        { options, inputs }:
        let
          inherit (inputs.nixpkgs) pkgs lib;
          inherit (pkgs) linkFarm writeText;
          inherit (lib.generators) toGitINI;
        in
        linkFarm "gitconfig" [
          { name = "git/config"; path = writeText "config" (toGitINI options.iniConfig); }
          { name = "git/ignore"; path = options.ignoreFile; }
        ];
    };
  };

  impl =
    { options, inputs }:
    let
      inherit (inputs.nixpkgs) pkgs;
    in
    inputs.mkWrapper {
      name = "git"; # Default derivation name is git-with-svn
      package = pkgs.gitFull;
      extraPaths = [ options.configDir ];
      environment = {
        XDG_CONFIG_HOME = "$out";
      };
    };
}
