{
  baseNix =
  [
    /baseNix/os
    ./baseNix/software
    ./baseNix/system

    ./packages/nixPackages.nix
  ];

  baseHome =
  [
    /baseHome/os
    ./baseHome/software

    ./packages/homePackages.nix
  ]
}