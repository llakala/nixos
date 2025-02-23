{ luaPackages, fetchFromGitHub, fetchurl, localPackages }:

let
  luaDeps = with luaPackages;
  [
    compat53
    bit32
    lua-term
  ];

  localDeps = with localPackages;
  [
    hump
    wcwidth
  ];

in
luaPackages.buildLuarocksPackage
{
  pname = "sirocco";
  version = "0.0.1-5";
  knownRockspec =
  (fetchurl
  {
    url = "mirror://luarocks/sirocco-0.0.1-5.rockspec";
    sha256 = "0bs2zcy8sng4x16clfz47cn4l6fw43rj224vjgmnkfvp9nznd4b4";
  }).outPath;

  src = fetchFromGitHub
  {
    owner = "giann";
    repo = "sirocco";
    rev = "b2af2d336e808e763b424d2ea42e6a2c2b4aa24d";
    hash = "sha256-LcdHV+STHNZzRaw/aoIWi71Gx1t4+7uHVoP9w6Rrc9Y=";
    fetchSubmodules = true;
  };

  disabled = luaPackages.luaOlder "5.1";
  propagatedBuildInputs = luaDeps ++ localDeps;

  meta = {
    homepage = "https://github.com/giann/sirocco";
    description = "A collection of useful cli prompts";
    license.fullName = "MIT/X11";
  };
}
