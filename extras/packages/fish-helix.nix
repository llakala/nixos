{ fishPlugins, fetchFromGitHub }:

fishPlugins.buildFishPlugin {
  pname = "fish-helix";
  version = "IDK";

  src = fetchFromGitHub {
    owner = "sshilovsky";
    repo = "fish-helix";
    rev = "8a5c7999ec67ae6d70de11334aa888734b3af8d7";
    hash = "sha256-04cL9/m5v0/5dkqz0tEqurOY+5sDjCB5mMKvqgpV4vM=";
  };

  # TODO: ADD META
}
