{ adios }:
let
  inherit (adios) types;
in {
  name = "kitty";

  inputs = {
    mkWrapper.path = "/mkWrapper";
    nixpkgs.path = "/nixpkgs";
  };

  options = {
    configFile = {
      type = types.path;
    };
    themeFile = {
      type = types.union [ types.string types.path ];
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
    in
    inputs.mkWrapper {
      package = pkgs.kitty;
      preWrap = ''
        mkdir -p $out/kitty
      '';
      symlinks = {
        "$out/kitty/kitty.conf" = options.configFile;
        "$out/kitty/current-theme.conf" = options.themeFile;
      };
      environment = {
        KITTY_CONFIG_DIRECTORY = "$out/kitty";
      };
    };
}
