{
  luaPackages,
  fetchFromGitHub,
  fetchurl,
  localPackages,
  lib,
}:

let
  luaDeps = with luaPackages;
  [
    compat53
    lpeg
    argparse # NOT the one from pkgs
  ];

  localDeps = with localPackages;
  [
    sirocco
    hump
  ];

in luaPackages.buildLuarocksPackage {
  pname = "croissant";
  version = "0.0.1-6";

  knownRockspec =
  (fetchurl
  {
    url = "mirror://luarocks/croissant-0.0.1-6.rockspec";
    sha256 = "0jdj7akx9r1ak40ff1997f7i6d5hw8533w21fckdvvpyg01kc8qz";
  }).outPath;

  src = fetchFromGitHub
  {
    owner = "giann";
    repo = "croissant";
    rev = "dc633a0ac3b5bcab9b72b660e926af80944125b3";
    hash = "sha256-EtbBuXQTzIfoQIhe9kXcRMs2rSfpgF2MaaFnsdMyN3Y=";
  };

  disabled = luaPackages.luaOlder "5.1";
  propagatedBuildInputs = luaDeps ++ localDeps;

  meta =
  {
    homepage = "https://github.com/giann/croissant";
    description = "A Lua REPL implemented in Lua";
    license.fullName = "MIT/X11";
  };
}
