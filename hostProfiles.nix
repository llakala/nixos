# hostSelection.nix

{
  lib,
  pkgs,
  pkgs-stable,
  vars,
  inputs,
}:


nixBase =
{
  modules =
  [
    ./nixos/os
    ./nixos/software
  ];
  packages = ./packages/nixos-pkgs.nix;
  args = { inherit pkgs-stable vars inputs; };
};

homeBase =
{
  modules =
  [
    ./home/os
    ./home/software
  ];
  packages = ./packages/home-pkgs.nix;
  args = { inherit pkgs-stable vars inputs; };
};

configMap =
{

  "desktop" =
  {
    nixos =
    {
      inherit nixBase;
      hostConfig = ./desktop/nixos;
    };
    home =
    {
      inherit homeBase;
      hostConfig = ./desktop/home;
    };
  };


  "framework" =
  {
    nixos =
    {
      inherit nixBase;
      hostConfig = ./framework/nixos;
    };
    home =
    {
      inherit homeBase;
      hostConfig = ./framework/home;
    };
  };


};
