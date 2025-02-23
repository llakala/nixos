{ luaPackages, fetchFromGitHub, fetchurl }:

luaPackages.buildLuarocksPackage
{
  pname = "hump";
  version = "0.4-2";
  knownRockspec = (fetchurl {
    url = "mirror://luarocks/hump-0.4-2.rockspec";
    sha256 = "0j89rznvq90bvjsj1mj9plxmxj8c7b4jkqsllw882f8xscdqq2sa";
  }).outPath;

  src = fetchFromGitHub
  {
    owner = "vrld";
    repo = "hump";
    rev = "08937cc0ecf72d1a964a8de6cd552c5e136bf0d4";
    hash = "sha256-CQmyS7ABj2dZJoI+VYSuLa6md6OoJrJ5TT0w4Cj7KG8=";
  };

  disabled = luaPackages.luaOlder "5.1";

  meta = {
    homepage = "https://hump.readthedocs.io";
    description = "Lightweight game development utilities";
    license.fullName = "MIT";
  };
}
