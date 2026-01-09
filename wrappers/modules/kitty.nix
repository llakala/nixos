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
    settings = {
      type = types.attrs;
    };
    configFile = {
      type = types.pathLike;
    };

    theme = {
      type = types.string;
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
    let
      inherit (builtins) concatStringsSep;
      inherit (inputs.nixpkgs) pkgs lib;
      # Slightly modified from hjr source - the one defined in hm does a lot of
      # extra nonsense, that im hoping isnt necessary
      generator = pkgs.formats.keyValue {
        listToValue = list: concatStringsSep " " (map toString list);
        mkKeyValue = lib.generators.mkKeyValueDefault {
          mkValueString = value:
            if value == true then "yes"
            else if value == false then "no"
            else lib.generators.mkValueStringDefault {} value;
        } " ";
      };
    in
    assert !(options ? configFile && options ? settings);
    assert !(options ? themeFile && options ? theme);
    inputs.mkWrapper {
      inherit (options) package;
      preWrap = ''
        mkdir -p $out/kitty
      '';
      symlinks = {
        "$out/kitty/kitty.conf" =
          if options ? configFile then options.configFile
          else if options ? settings then generator.generate "kitty" options.settings
          else null;

        "$out/kitty/current-theme.conf" =
          options.themeFile or "${inputs.nixpkgs.pkgs.kitty-themes}/share/kitty-themes/themes/${options.theme}.conf";
      };
      environment = {
        KITTY_CONFIG_DIRECTORY = "$out/kitty";
      };
    };
}
