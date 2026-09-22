{ vimPlugins }:

vimPlugins.snacks-nvim.overrideAttrs (prevAttrs: {
  # Patch from my PR that fixes a performance issue
  # See https://github.com/folke/snacks.nvim/pull/2805
  patches = (prevAttrs.patches or []) ++ [ ./scope-perf.patch ];
})
