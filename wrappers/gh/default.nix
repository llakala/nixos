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
    # For consumption by the git wrapper
    iniConfig = {
      type = types.attrs;
      defaultFunc = { options, inputs }: import ./iniConfig.nix { inherit options inputs; };
    };
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
