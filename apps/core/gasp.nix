{ inputs, pkgs, ... }:

{
  environment.systemPackages = with inputs.gasp.legacyPackages.${pkgs.system};
  [

    # Git Hire Patch (stage)
    ghp

    # Git Fire Patch (unstage)
    gfp

    # Git Kill Patch (reset)
    gkp

    splitpatch
  ];
}
