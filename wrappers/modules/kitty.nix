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
      type = types.pathLike;
    };
    themeFile = {
      type = types.pathLike;
    };
    package = {
      type = types.derivation;
      defaultFunc = { inputs }: inputs.nixpkgs.pkgs.kitty;
    };
  };

  mutations."/fish".interactiveShellInit =
    { options }:
    # fish
    ''
      # We can't use the `shell_integration` output of our wrapper, since wrappers
      # don't preserve attributes like this
      source "${options.package.shell_integration}/fish/vendor_conf.d/kitty-shell-integration.fish"
      set --prepend fish_complete_path "${options.package.shell_integration}/fish/vendor_completions.d"
    '';

  impl =
    { options, inputs }:
    inputs.mkWrapper {
      inherit (options) package;
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
