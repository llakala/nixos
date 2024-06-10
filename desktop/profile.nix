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

    nixos.args = { };
    home.args = { };
}
