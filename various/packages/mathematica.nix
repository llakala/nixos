/*
NOTE: All the examples here will use the current version and my username, for easier copy/pasting
Change this to your own stuff if you're copying from me, or are me in the future

To install mathematica, first check which version to install, specified here:
https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/ma/mathematica/versions.nix

Next, download the installer for the proper version. You can choose a version here:
https://account.wolfram.com/products/downloads/mathematica
This is the link to the version I'm using here:
https://account.wolfram.com/dl/WolframApp?version=14.3&platform=Linux&includesDocumentation=false

Next, get the hash below, via this command:
nix-store --query --hash $(nix store add-path /home/emanresu/Downloads/Wolfram_14.3.0_LIN.sh --name 'Wolfram_14.3.0_LIN.sh')

The next rebuild will take forever, wait it out.
Now, mathematica should be installed!

NOTE: the added version MIGHT go away on a GC. I've had it disappear randomly every so often,
and this time, the timing lined up with a recent GC. I'm not sure if there's a way to avoid
this. if you see this and know a method, please make an issue to let me know!
*/
{ mathematica, requireFile }:

mathematica.override {
  source = requireFile {
    name = "Wolfram_14.3.0_LIN.sh"; # Name of shell script we installed
    sha256 = "18a8wf9j6n4dp631psa254hyniklm61i3qqrvvnz1sgfvd1hl6cf";
    message = "you fucked up bbg";
    hashMode = "recursive";
  };
}
