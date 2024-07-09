{ pkgs ? import <nixpkgs> { }, lib, }:

pkgs.mkShell
{

  NIX_LD = lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker";

  NIX_LD_LIBRARY_PATH = lib.makeLibraryPath
  [
    pkgs.stdenv.cc.cc
    pkgs.openssl
    # ...s  
  ];

  shellHook = ''

  '';
}