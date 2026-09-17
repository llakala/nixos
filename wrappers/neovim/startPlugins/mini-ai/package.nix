{ vimPlugins }:

vimPlugins.mini-ai.overrideAttrs {
  # Asked about PRing this - echasnovski said no (typical)
  patches = ./add-covering-binds.patch;
}
