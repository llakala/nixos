{
  nix =
  {
    modules =
    [
      ./baseNix/os
      ./baseNix/software
      ./baseNix/system

      ./packages/nixPackages.nix

      ./overlays
    ];
  };

  home =
  {
    modules =
    [
      ./baseHome/os
      ./baseHome/software
      ./baseHome/system

      ./packages/homePackages.nix

      ./overlays
    ];
  };

  common =
  {
    args =
    {
      inherit pkgs-unstable vars;
    }
  }
}