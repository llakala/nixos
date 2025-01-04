# To install mathematica, first check which version to install, specified here:
# https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/science/math/mathematica/versions.nix
# Next, download the installer for the proper version. You can choose a version here:
# https://account.wolfram.com/products/downloads/mathematica
# Add the downloaded file to the nix store via:
# nix-store --add-fixed sha256 path/to/FILE.sh
# Next, update the hash below, via this command:
# nix-store --query --hash $(nix store add-path path/to/FILE.sh --name 'FILE.sh')
# The next rebuild seemingly takes forever, wait it out.
# Now, mathematica should be installed!
{ pkgs, ... }:

let
  subnautica = pkgs.mathematica.override
  {
    source = pkgs.requireFile
    {
      name = "Wolfram_14.1.0_LIN.sh"; # Name of shell script we installed
      sha256 = "17z5aq7qaind1zkyandf1aq76iy0a0yqmj8qmc0wrc15s5k1lg1q";
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
