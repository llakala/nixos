{ pkgs, lib, ... }:

let
  myPackage = pkgs.rustPlatform.buildRustPackage rec
  {
    pname = "colo";
    version = "0.4.1";

    src = pkgs.fetchFromGitHub
    {
      owner = "Aloso";
      repo = "colo";
      rev = "v${version}";
      sha256 = "sha256-ocGzZR4gM2sInXccbHxh7Vf0kcZTZOnVW0KM6zp/pR8=";
    };

    cargoHash = "sha256-HjEYC7FUHpxNWy/nUVO65O3f/RdT9hYZc3TpcqP3SSM=";
  };

in
{
  environment.systemPackages = lib.singleton myPackage;
}
