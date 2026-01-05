{ adios }:
let
  inherit (adios) types;
in {
  name = "zoxide";

  inputs = {
    mkWrapper.path = "/mkWrapper";
    nixpkgs.path = "/nixpkgs";
  };

  options = {
    flags = {
      type = types.string;
      default = "";
    };
    excludedDirs = {
      type = types.string;
    };
    package = {
      type = types.derivation;
      defaultFunc = { inputs }: inputs.nixpkgs.pkgs.zoxide;
    };
  };

  mutations."/fish".interactiveShellInit =
    { inputs, options }:
    let
      inherit (inputs.nixpkgs) lib;
      finalWrapper = options {};
    in
    # fish
    ''
      ${lib.getExe finalWrapper} init fish ${options.flags} | source
    '';

  impl =
    { options, inputs }:
    if !options ? excludedDirs then options.package
    else inputs.mkWrapper {
      inherit (options) package;
      environment = {
        _ZO_EXCLUDE_DIRS = options.excludedDirs;
      };
    };
}
