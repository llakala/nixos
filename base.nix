{
  nix =
  {
    modules =
    [
      ./baseNix/os
      ./baseNix/software
      ./baseNix/system

      ./packages/nixPackages.nix
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
    ];
  };
}