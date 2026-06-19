{ stdenv, fetchFromGitHub, perl, ruby }:

stdenv.mkDerivation {
  pname = "splitpatch";
  version = "0-unstable-2025-03-04";

  src = fetchFromGitHub {
    owner = "llakala";
    repo = "splitpatch";
    rev = "08e4491186951f08bbea3e7c972a0f86a4a8d046";
    hash = "sha256-8xiigSnYY8fofcd5az8GUNcplmba5eUbLG1mU7e4KWA=";
  };

  buildInputs = [
    perl
    ruby
  ];

  preInstall = ''
    mkdir -p $out/share/man
  '';

  makeFlags = [
    "INSTALL_MKDIR=mkdir"
    "PREFIX=$(out)"
  ];
}
