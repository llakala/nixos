{ vimPlugins }:

vimPlugins.rainbow-delimiters-nvim.overrideAttrs (prevAttrs: {
  # See https://github.com/HiPhish/rainbow-delimiters.nvim/pull/219
  # also include changes to the files since 0.12 released
  patches = (prevAttrs.patches or []) ++ [ ./ocaml-changes.patch ];
})
