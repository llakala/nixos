# To install mathematica, first check which version to install, specified here:
# https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/science/math/mathematica/versions.nix
# Next, download the installer for the proper version. The following example link uses 14.0.0
# https://account.wolfram.com/dl/Mathematica?version=14.0&platform=Linux&downloadManager=false
# Add the downloaded file to the nix store via:
# nix-store --add-fixed sha256 ~/Downloads/Mathematica_14.0.0_BNDL_LINUX.sh
# The next rebuild seemingly takes forever, wait it out.
# Now, mathematica should be installed!

{ pkgs, ... }:
let
  subnautica = pkgs.mathematica.override
  {
    source = pkgs.requireFile
    {
      name = "Mathematica_14.0.0_BNDL_LINUX.sh"; # Name of shell script we installed
      sha256 = "16hfh8kzdjy116nkcd6fr5xaabqjsv3h1jb0y0p74nqqvsxrd0da"; # Grab this via `nix-store --query --hash $(nix store add-path Mathematica_14.0.0_BNDL_LINUX.sh --name 'Mathematica_14.0.0_BNDL_LINUX.sh')`
      message = "you fucked up bbg";
      hashMode = "recursive";
    };
  };
in
{
  environment.systemPackages =
  [
    subnautica
  ];
}
