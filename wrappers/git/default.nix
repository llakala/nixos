{ adios }:
let
  inherit (adios) types;
in {
  name = "git";

  inputs = {
    mkWrapper.path = "/mkWrapper";
    nixpkgs.path = "/nixpkgs";
  };

  mutators = [ "/gh" "/less" "/diff-so-fancy" ];

  mutations."/fish".abbreviations = _: import ./abbreviations.nix;

  options = {
    ignoreFile = {
      type = types.path;
      default = ./ignore;
    };
    iniConfig = {
      type = types.attrs;
      mutable = true;
      mutator = {
        type = types.attrs;
        mergeFunc =
          { mutators, inputs }:
          let
            inherit (inputs.nixpkgs) lib;
            inherit (builtins) foldl' attrValues;
            settings = import ./settings.nix { inherit inputs; };
          in
          foldl' (acc: elem: lib.recursiveUpdate acc elem) {} ([ settings ] ++ attrValues mutators);
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
