{ adios }:
let
  inherit (adios) types;
in
{
  name = "kitty";

  inputs = {
    nixpkgs.path = "/nixpkgs";
    self.path = "/self";
  };

  options.configFile = {
    type = types.path;
    default = ./kitty.conf;
  };

  options.themeFile = {
    type = types.string;
    defaultFunc = { inputs, ... }: "${inputs.nixpkgs.pkgs.kitty-themes}/share/kitty-themes/themes/Kaolin_Aurora.conf";
  };

  options.drv = {
    type = types.derivation;
    defaultFunc =
      { options, inputs }:
      let
        inherit (inputs.nixpkgs) pkgs;
        inherit (pkgs) symlinkJoin makeWrapper;
      in
      symlinkJoin {
        name = "kitty-wrapped";
        paths = [
          pkgs.kitty
        ];
        buildInputs = [ makeWrapper ];
        postBuild = /* bash */ ''
          mkdir -p $out/kitty
          ln -sf ${options.configFile} $out/kitty/kitty.conf
          ln -sf ${options.themeFile} $out/kitty/current-theme.conf
          wrapProgram $out/bin/kitty \
            --set KITTY_CONFIG_DIRECTORY $out/kitty \
        '';
        meta.mainProgram = "kitty";
      };
  };
}
