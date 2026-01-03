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
    let
      inherit (inputs.nixpkgs) pkgs;
    in
    if !options ? excludedDirs then pkgs.zoxide
    else inputs.mkWrapper {
      package = pkgs.zoxide;
      environment = {
        _ZO_EXCLUDE_DIRS = options.excludedDirs;
      };
    };
}
