{ vimPlugins }:

vimPlugins.mini-indentscope.overrideAttrs (prevAttrs: {
  # Simple patch that makes a line with only spaces count as indented
  patches = (prevAttrs.patches or []) ++ [ ./trailing-lines.patch ] ;
})
