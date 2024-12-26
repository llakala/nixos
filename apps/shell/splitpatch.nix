{ pkgs, lib, ... }:

let
  pkg = pkgs.stdenv.mkDerivation
  {
    pname = "splitpatch";
    version = "TEST";

    src = pkgs.fetchFromGitHub
    {
      owner = "jaalto";
      repo = "splitpatch";
      rev = "5b1905e670cd79019944db8daf4e4aaea3136b32";
      hash = "sha256-RlqJbc0qRprOe9Mx/KMEdnbG+x0thEPk0vY3T+1nREU=";
    };

    buildInputs = with pkgs;
    [
      perl
      ruby
    ];

    prePatch =
    ''
      substituteInPlace Makefile \
        --replace /usr/bin/install "install" \
    '';

    makeFlags = [ "PREFIX=$(out)" ];
  };
in
{
  environment.systemPackages = lib.singleton pkg;
}
