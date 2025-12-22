{ adios }:
let
  inherit (adios) types;
in {
  name = "gh";

  inputs = {
    nixpkgs.path = "/nixpkgs";
  };

  options = {
    configDir = {
      type = types.path;
      default = ./gh;
    };
  };

  mutations = {
    "/git".iniConfig = { options, inputs }: import ./iniConfig.nix { inherit options inputs; };
    "/fish".abbreviations = _: import ./abbreviations.nix;
  };

  impl =
    { options, inputs }:
    let
      inherit (inputs.nixpkgs) pkgs;
      inherit (pkgs) symlinkJoin makeWrapper;
    in
    symlinkJoin {
      name = "gh-wrapped";
      paths = [ pkgs.gh ];
      buildInputs = [ makeWrapper ];
      postBuild = /* bash */ ''
        ln -s ${options.configDir} $out/gh
        wrapProgram $out/bin/gh \
          --set GH_CONFIG_DIR $out/gh \
      '';
      meta.mainProgram = "gh";
    };
}
