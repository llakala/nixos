# hostSelection.nix

{
  inputs,
}:



{
  "desktop" =
  {
    system = "x86_64-linux";

    nixos.modules =
    [
      ./desktop/nixos
    ];

    home.modules =
    [
      ./framework/home
    ];

    nixos.packages = { };
    home.packages = { };

    nixos.args = { };
    home.args = { };
  };


  "framework" =
  {
    system = "x86_64-linux";


    nixos.modules =
    [
      ./framework/nixos
    ];
    home.modules =
    [
      ./framework/home
    ];

    nixos.packages = { };
    home.packages = { };

    nixos.args = { };
    home.args = { };
  };


};
