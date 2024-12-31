{ inputs, pkgs, ... }:

{
  environment.systemPackages = with inputs.gasp.packages.${pkgs.system};
  [
    gasp
    splitpatch
  ];
}