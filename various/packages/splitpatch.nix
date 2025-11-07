{ stdenv, fetchFromGitHub, perl, ruby }:

stdenv.mkDerivation {
  pname = "splitpatch";

  # TODO: bump to latest version
  version = "0-unstable-2025-03-04";

  src = fetchFromGitHub {
    owner = "jaalto";
    repo = "splitpatch";
    rev = "d35dbf194a112ab8b8408d5f27ba5373be4c4a53";
    hash = "sha256-4nMykkDhNQBITq5rgRlj20W/S5B2Fy3pUXXJ9wA/kTQ=";
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
