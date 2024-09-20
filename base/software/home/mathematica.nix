{ pkgs, ... }:

# To install mathematica, first download the installer from
# account.wolfram.com/dl/Mathematica?version=14.0&platform=Linux&downloadManager=false. The version needs to be the same one from nixpkgs.
# Next, run
# `nix-store --query --hash $(nix store add-path Mathematica_14.0.0_BNDL_LINUX.sh)`
# in order to make it available and find the hash.
# Finally, paste the outputted hash into sha256 below

let
  version = "14.0.0";

  my_mathematica = pkgs.mathematica.override
  {
    source = pkgs.requireFile
    {
      name = "Mathematica_${version}_BNDL_LINUX.sh";
      hashMode = "recursive";
      sha256 = "sha256:0rmrspvf1aqgpvl9g53xmibw28f83vzrrhw6dmfm4l7y05cr315y";
      message = "TODO";
    };
  };
in
{
  home.packages =
  [
    my_mathematica
  ];
}