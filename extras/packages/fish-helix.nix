{ lib, fishPlugins, fetchFromGitHub, }:

fishPlugins.buildFishPlugin
{
  pname = "fish-helix";
  version = "IDK";

  # Fetch from my own fork so the main file can be renamed
  src = fetchFromGitHub
  {
    owner = "sshilovsky";
    repo = "fish-helix";
    rev = "8a5c7999ec67ae6d70de11334aa888734b3af8d7";
    hash = "sha256-nN86dEIA+mi+yWwOJHCVprT2KZmDanUWfxsZsN4p9s4=";
  };
}
