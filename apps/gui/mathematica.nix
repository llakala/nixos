/*
NOTE: All the examples here will use the current version and my username, for easier copy/pasting
Change this to your own stuff if you're copying from me, or are me in the future

To install mathematica, first check which version to install, specified here:
https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/science/math/mathematica/versions.nix

Next, download the installer for the proper version. You can choose a version here:
https://account.wolfram.com/products/downloads/mathematica
This is the link to the version I'm using here:
https://account.wolfram.com/dl/Mathematica?version=14.1&platform=Linux&downloadManager=false&includesDocumentation=false

Add the downloaded file to the nix store via:
nix-store --add-fixed sha256 /home/emanresu/Downloads/Wolfram_14.1.0_LIN.sh

Next, update the hash below, via this command:
nix-store --query --hash $(nix store add-path /home/emanresu/Downloads/Wolfram_14.1.0_LIN.sh --name 'Wolfram_14.1.0_LIN.sh')

The next rebuild will take forever, wait it out.
Now, mathematica should be installed!

NOTE: the added version MIGHT go away on a GC. I've had it disappear randomly every so often,
and this time, the timing lined up with a recent GC. I'm not sure if there's a way to avoid
this. if you see this and know a method, please make an issue to let me know!
*/

{ pkgs, ... }:

let
  subnautica = pkgs.mathematica.override {
    source = pkgs.requireFile {
      name = "Wolfram_14.1.0_LIN.sh"; # Name of shell script we installed
      sha256 = "17z5aq7qaind1zkyandf1aq76iy0a0yqmj8qmc0wrc15s5k1lg1q";
      message = "you fucked up bbg";
      hashMode = "recursive";
    };
  };
in {
  environment.systemPackages = [
    subnautica
  ];
}
