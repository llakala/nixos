# To install mathematica, first check which version to install, specified here:
# https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/science/math/mathematica/versions.nix
# Next, download the installer for the proper version. The following example link uses 14.0.0
# https://account.wolfram.com/dl/Mathematica?version=14.0&platform=Linux&downloadManager=false
# Add the downloaded file to the nix store via:
# nix-store --add-fixed sha256 ~/Downloads/Mathematica_14.0.0_BNDL_LINUX.sh
# The next rebuild seemingly takes forever, wait it out.
# Now, mathematica should be installed!

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs;
  [
    mathematica
  ];
}