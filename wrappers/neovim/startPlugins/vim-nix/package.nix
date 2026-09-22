{ vimPlugins }:

vimPlugins.vim-nix.overrideAttrs (prevAttrs: {
  # pointing to my fork with some indent changes and some startup logic removed
  patches = (prevAttrs.patches or []) ++ [ ./personal-tweaks.patch ];
})
