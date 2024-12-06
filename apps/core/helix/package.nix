{ inputs, pkgs,  ... }:

let
  patchList = # Adding unmerged QOL PRs
  [
    (pkgs.fetchpatch {
      url = "https://patch-diff.githubusercontent.com/raw/helix-editor/helix/pull/11164.diff";
      hash = "sha256-GXyGD1WNENxphQPId+0ory3sYQftWqK7t2iBtMVU4nU=";
    })

    # (pkgs.fetchpatch {
    #   url = "https://patch-diff.githubusercontent.com/raw/helix-editor/helix/pull/11973.diff";
    #   hash = "sha256-ATkJRh7GldSKhepfo46FUJVGylpPZEQHyw0c6Q0lyUc=";
    # })
  ];

  helixPackages = inputs.helix-unstable.packages.${pkgs.system}; # TODO ADD COMMENT
  patchedHelix = pkgs.helix.overrideAttrs
  (
    oldAttrs:
    {
      patches = (oldAttrs.patches or []) ++ patchList;
    }
  );

in
{
  hm.programs.helix.package = patchedHelix;
}
