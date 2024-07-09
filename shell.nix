{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell
{
  nativeBuildInputs = with pkgs; [
    nodejs
  ];

  shellHook = ''
    echo "weclome"
    echo "to my shell!" | ${pkgs.lolcat}/bin/lolcat
  '';

  COLOR = "blue";
}