{
  # I wish this could be true so we could use apropos, but it slows down rebuilds too much
  documentation.man.generateCaches = false;
  hm.programs.man.generateCaches = false;

  documentation = # Apparently speeds up rebuilds
  {
    nixos.enable = false;
  };
}
