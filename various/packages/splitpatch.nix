{ stdenv, fetchFromGitHub, perl, ruby }:

stdenv.mkDerivation {
  pname = "splitpatch";
  version = "0-unstable-2025-03-04";

  src = fetchFromGitHub {
    owner = "llakala";
    repo = "splitpatch";
    rev = "3fff10e02fc2c7abd7de8c3cc3f2fab2a87f5ff8";
    hash = "sha256-i+zLHI43A9yFmWnKouZzDIXjINTw/DaI9kLIIsra0ww=";
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
