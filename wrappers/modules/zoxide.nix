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
      type = types.listOf types.string;
      description = ''
        Flags to be automatically appended when creating the zoxide shell integration.

        See the documentation of valid flags:
        https://github.com/ajeetdsouza/zoxide#flags
      '';
      default = [];
    };
    excludedDirs = {
      type = types.string;
      description = ''
        Directory globs that won't be added to the database when navigating with zoxide.
      '';
    };
    package = {
      type = types.derivation;
      description = "The zoxide package to be wrapped.";
      defaultFunc = { inputs }: inputs.nixpkgs.pkgs.zoxide;
    };
  };

  mutations."/fish".interactiveShellInit =
    { inputs, options }:
    let
      inherit (inputs.nixpkgs) lib;
      inherit (builtins) concatStringsSep;
      finalWrapper = options {};
    in
    # fish
    ''
      ${lib.getExe finalWrapper} init fish ${concatStringsSep " " options.flags} | source
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
