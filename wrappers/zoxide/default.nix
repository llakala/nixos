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
      defaultFunc = { inputs }: inputs.nixpkgs.lib.fileContents ./ZOXIDE_FLAGS;
    };

    # I have Yazi set up to auto-update the zoxide database based on where I go --
    # and neovim integration into Zoxide. However, this means that if i have a repo
    # called `reponame`, and a subdirectory `reponame/src/reponame`, the one under
    # src gets higher precedence. This isn't what we want! To get around this, we
    # filter out subdirs of `src`, so we don't open the wrong directory.
    excludedDirs = {
      type = types.string;
      defaultFunc = { inputs }: inputs.nixpkgs.lib.fileContents ./_ZO_EXCLUDE_DIRS;
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
    inputs.mkWrapper {
      package = pkgs.zoxide;
      environment = {
        _ZO_EXCLUDE_DIRS = options.excludedDirs;
      };
    };
}
