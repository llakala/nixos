{ inputs, pkgs,  ... }:

let
  patchList = # Adding unmerged QOL PRs
  [
    # (pkgs.fetchpatch {
    #   url = "https://patch-diff.githubusercontent.com/raw/helix-editor/helix/pull/11164.patch";
    #   hash = "sha256-AZOSEBZU6oWXmGoT61C+icw882MxNvdSnGBPm0Qwbq8=";
    # })

    ./patches/1.patch
    ./patches/2.patch
    # ./patches/3.patch
  ];

  helixPackages = inputs.helix-unstable.packages.${pkgs.system};
  patchedHelix = helixPackages.helix-unwrapped.overrideAttrs
  (
    oldAttrs:
    {
      patches = (oldAttrs.patches or []) ++ patchList;
      # patchFlags = (oldAttrs.patchFlags or []) ++ [ "-p1" ];
    }
  );

in
{
  hm.programs.helix.package = helixPackages.helix.passthru.wrapper patchedHelix;
}
