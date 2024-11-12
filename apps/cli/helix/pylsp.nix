{ lib, pkgs, ... }:

# Code referenced from:
# https://github.com/maxbrunet/dotfiles/blob/9a114ea0f9c8cdeb0f07d762f329bdbbe2973e50/nix/common.nix#L138
# https://github.com/NixOS/nixpkgs/issues/229337#issuecomment-1877951362
let
  oldlsp = pkgs.python3Packages.python-lsp-server;
  newlsp = oldlsp.overridePythonAttrs
  (oldAttrs:
    {
      propagatedBuildInputs =
        (oldAttrs.propagatedBuildInputs or [])
        ++ oldlsp.optional-dependencies.all; # A list of bundled pylsp plugins
    }
  );

in
{
  hm.programs.helix.languages =
  {
    language = lib.singleton
    {
      name = "python";
      auto-format = false;
      language-servers = lib.singleton "pylsp";
    };

    language-server.pylsp.command = lib.getExe newlsp;

    language-server.pylsp.config.pylsp.plugins =
    {
      pycodestyle.enabled = true;
    };

  };

}
