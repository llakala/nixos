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
    packages = ./packages/nixos-pkgs.nix;
    args = { inherit pkgs-stable vars inputs; };
  };

  home =
  {
    modules =
    [
      ./home/os
      ./home/software
    ];
    packages = ./packages/home-pkgs.nix;
    args = { inherit pkgs-stable vars inputs; };
  };
}