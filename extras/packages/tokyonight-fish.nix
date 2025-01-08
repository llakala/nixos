# Taken from https://github.com/pope/personal/blob/04652c9/etc/nixos/packages/fish-tokyonight/default.nix#L4
# and https://github.com/pope/personal/blob/04652c9/etc/nixos/packages/_sources/generated.nix#L31
{ stdenv, fetchFromGitHub, }:

stdenv.mkDerivation rec
{
  pname = "tokyonight-fish";
  version = "v4.8.0";

  src = fetchFromGitHub
  {
    owner = "vitallium";
    repo = "tokyonight-fish";
    rev = version;
    fetchSubmodules = false;
    sha256 = "sha256-JI1kTez4CeMpSKcSikFUee15N48zkJJOvLHCi0H2PUc=";
  };

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  installPhase =
  ''
    install -D -t $out/share/fish/themes $src/themes/*
  '';}
