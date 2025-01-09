{ inputs, pkgs, ... }:

{
  environment.systemPackages = with inputs.gasp.packages.${pkgs.system};
  [
    gsap # Git Stage A Patch
    guap # Git Unstage A Patch
    gcap # Git Clean A Patch

    splitpatch
  ];
}