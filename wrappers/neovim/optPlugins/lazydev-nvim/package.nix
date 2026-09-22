{ vimPlugins }:

vimPlugins.lazydev-nvim.overrideAttrs (prevAttrs: {
  # Patch that makes lazydev properly follow `workspace.ignoreDir`
  # see https://github.com/folke/lazydev.nvim/pull/113
  patches = (prevAttrs.patches or []) ++ [ ./ignore-dir.patch ];
})
