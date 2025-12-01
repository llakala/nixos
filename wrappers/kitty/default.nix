{ adios }:
let
  inherit (adios) types;
in {
  name = "kitty";

  inputs = {
    nixpkgs.path = "/nixpkgs";
  };

  options = {
    configFile = {
      type = types.path;
      default = ./kitty.conf;
    };
    themeFile = {
      type = types.union [ types.string types.path ];
      defaultFunc = { inputs }: import ./theme.nix { inherit inputs; };
    };
  };

  impl =
    { options, inputs }:
    let
      inherit (inputs.nixpkgs) pkgs;
      inherit (pkgs) symlinkJoin makeWrapper;
    in
    symlinkJoin {
      name = "kitty-wrapped";
      paths = [ pkgs.kitty ];
      buildInputs = [ makeWrapper ];
      postBuild = /* bash */ ''
        mkdir -p $out/kitty
        ln -s ${options.configFile} $out/kitty/kitty.conf
        ln -s ${options.themeFile} $out/kitty/current-theme.conf
        wrapProgram $out/bin/kitty \
          --set KITTY_CONFIG_DIRECTORY $out/kitty \
      '';
      meta.mainProgram = "kitty";
    };
}
