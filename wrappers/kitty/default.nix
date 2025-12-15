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

  mutations."/fish".interactiveShellInit =
    { inputs }:
    let
      inherit (inputs.nixpkgs) pkgs;
    in
    # fish
    ''
      # We can't use the `shell_integration` output of our wrapper, since wrappers
      # don't preserve attributes like this
      source "${pkgs.kitty.shell_integration}/fish/vendor_conf.d/kitty-shell-integration.fish"
      set --prepend fish_complete_path "${pkgs.kitty.shell_integration}/fish/vendor_completions.d"
    '';

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
