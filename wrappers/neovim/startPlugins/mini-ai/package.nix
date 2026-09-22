{ vimPlugins }:

vimPlugins.mini-ai.overrideAttrs (prevAttrs: {
  # Asked about PRing this - echasnovski said no (typical)
  patches = (prevAttrs.patches or []) ++ [ ./add-covering-binds.patch ];
})
