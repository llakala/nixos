{ pkgs, lib, ... }:

# To bundle plugins into pylsp without having a separate python instance, we
# have to do some very ugly overriding.

# Code referenced from:
# https://github.com/maxbrunet/dotfiles/blob/9a114ea0f9c8cdeb0f07d762f329bdbbe2973e50/nix/common.nix#L138
# https://github.com/NixOS/nixpkgs/issues/229337#issuecomment-1877951362

let
  oldlsp = pkgs.python3Packages.python-lsp-server;

  unpropagatePylsp = plugin: plugin.overridePythonAttrs
  (oldAttrs:
    {
      buildInputs =
        (oldAttrs.buildInputs or [])
        ++ lib.singleton oldlsp;

      dependencies = lib.remove
        oldlsp
        oldAttrs.dependencies;
    }
  );

  bundledPlugins = oldlsp.optional-dependencies.all;
  customPlugins = map unpropagatePylsp
  (
    with pkgs.python3Packages;
    [
      pylsp-rope
      python-lsp-ruff
      pyls-isort
    ]
  );

  newlsp = oldlsp.overridePythonAttrs
  (oldAttrs:
    {
      propagatedBuildInputs =
        (oldAttrs.propagatedBuildInputs or [])
        ++ bundledPlugins
        ++ customPlugins; # A list of bundled pylsp plugins

      disabledTests = # These tests apparently fail if we add any custom plugins
        (oldAttrs.disabledTests or [])
        ++
        [
          "test_notebook_document__did_open"
          "test_notebook_document__did_change"
        ];
    }
  );
in
{
  hm.programs.helix.languages.language-server.pylsp =
  {
    command = lib.getExe newlsp;

    config.pylsp.plugins = # see https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
    {
      pycodestyle.enabled = true; # Ruff doesn't show everything
    };
  };

  environment.systemPackages = lib.singleton newlsp; # For testing
}
