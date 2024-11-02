{
  documentation.man = 
  {
    generateCaches = false; # I wish this could be true so we could use apropos, but it slows down rebuilds too much
  };

  documentation = # Apparently speeds up rebuilds
  {
    nixos.enable = false;
  };
}
