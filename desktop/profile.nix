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

    nixos.packages = { };
    home.packages = { };

    nixos.args = { };
    home.args = { };
}