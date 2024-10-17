{ inputs, pkgs, ... }:
let
  rbld = inputs.rbld.packages.${pkgs.system}.rbld;
  unify = inputs.rbld.packages.${pkgs.system}.unify;

in
{
  environment.systemPackages = [ rbld unify ];
}
