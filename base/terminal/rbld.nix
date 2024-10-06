{ inputs, pkgs, ... }:
let
  system = pkgs.system; # Something like x86-64_linux

  rbld = inputs.rbld.packages.${system}.default;
in
{
  environment.systemPackages = [ rbld ];
}
