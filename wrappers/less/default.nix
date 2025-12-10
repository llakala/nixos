{ adios }:
let
  inherit (adios) types;
in {
  name = "less";

  inputs = {
    nixpkgs.path = "/nixpkgs";
  };

  options = {
    flags = {
      type = types.string;
      defaultFunc = { inputs }: inputs.nixpkgs.lib.fileContents ./LESS;
    };
    keybinds = {
      type = types.string;
      defaultFunc = { inputs }: inputs.nixpkgs.lib.fileContents ./lesskey;
    };
  };

  mutations = {
    "/git" = {
      iniConfig = { options, inputs }: import ./iniConfig.nix { inherit options inputs; };
    };
  };

  impl =
    { options, inputs }:
    let
      inherit (inputs.nixpkgs) pkgs;
      inherit (pkgs) symlinkJoin makeWrapper;
    in
    symlinkJoin {
      name = "less-wrapped";
      paths = [ pkgs.less ];
      buildInputs = [ makeWrapper ];
      postBuild = /* bash */ ''
        wrapProgram $out/bin/less \
          --set LESS "${options.flags}" \
          --set LESSKEY_CONTENT "${options.keybinds}"
      '';
      meta.mainProgram = "less";
    };
}
