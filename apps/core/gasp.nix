{ inputs, pkgs, ... }:

{
  environment.systemPackages = with inputs.gasp.legacyPackages.${pkgs.system};
  [
    ghp # Git Hire Patch (stage)
    gfp # Git Fire Patch (unstage)
    gkp # Git Kill Patch (reset)

    splitpatch
  ];
}
