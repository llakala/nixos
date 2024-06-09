{ }:

{
    system = "x86_64-linux";

    nixos.modules =
    [
        ./nixos
    ];

    home.modules =
    [
        ./home
    ];

    nixos.packages = 
    {
        ./packages/nixPackages.nix
    };
    home.packages = 
    {
        ./packages/homePackages.nix
    };

    nixos.args = { };
    home.args = { };
}
