{ adios }:
let
  inherit (adios) types;
in
{
  name = "zoxide";

  inputs = {
    nixpkgs.path = "/nixpkgs";
  };

  options.flags = {
    type = types.string;
    defaultFunc = { inputs }: inputs.nixpkgs.lib.fileContents ./ZOXIDE_FLAGS;
  };

  # I have Yazi set up to auto-update the zoxide database based on where I go --
  # and neovim integration into Zoxide. However, this means that if i have a repo
  # called `reponame`, and a subdirectory `reponame/src/reponame`, the one under
  # src gets higher precedence. This isn't what we want! To get around this, we
  # filter out subdirs of `src`, so we don't open the wrong directory.
  options.excludedDirs = {
    type = types.string;
    defaultFunc = { inputs }: inputs.nixpkgs.lib.fileContents ./_ZO_EXCLUDE_DIRS;
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
        name = "zoxide-wrapped";
        paths = [ pkgs.zoxide ];
        buildInputs = [ makeWrapper ];
        postBuild = /* bash */ ''
          # We don't add `options.flags` here, and instead inject them at the
          # shell init stage
          wrapProgram $out/bin/zoxide \
            --set _ZO_EXCLUDE_DIRS "${options.excludedDirs}"
        '';
        meta.mainProgram = "zoxide";
      };
  };
}
