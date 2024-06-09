{
  inputs,
  pkgs-stable,
  vars,
  ...
}:

{
  nixos =
  {
    modules =
    [
      ./nixos/os
      ./nixos/software
    ];
    packages = ./packages/nixPackages.nix;
    args = { inherit pkgs-stable vars inputs; };
  };

  home =
  {
    modules =
    [
      ./home/os
      ./home/software
    ];
    packages = ./packages/homePackages.nix;
    args = { inherit pkgs-stable vars inputs; };
  };
}