/*
  NOTE: All the examples here will use the current version and my username, for easier copy/pasting
  Change this to your own stuff if you're copying from me, or are me in the future

  To install mathematica, first check which version to install, specified here:
  https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/ma/mathematica/versions.nix

  Next, download the installer for the proper version. You can choose a version here:
  https://account.wolfram.com/products/downloads/mathematica
  This is the link to the version I'm using here:
  https://account.wolfram.com/dl/WolframApp?version=14.3&platform=Linux&includesDocumentation=false

  Next, add the file to the store and get the hash to put below, via this command:
  nix hash path $(nix-store --add /home/emanresu/Downloads/Wolfram_14.3.0_LIN.sh)

  The next rebuild will take forever, wait it out.
  Now, mathematica should be installed!

  note that this file will end up being destroyed on a gc, and next time nix
  needs to refer to it, you'll need to run the above command again. I don't
  think there's a very good workaround for this right now - see
  https://github.com/NixOS/nix/issues/7138
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
