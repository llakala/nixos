{ stdenv, cmake }:

stdenv.mkDerivation {
  name = "gps"; # Git Patch Splitter
  src = ./src;

  nativeBuildInputs = [ cmake ];
  installPhase = ''
    mkdir -p $out/bin
    mv gps $out/bin
  '';
}
