{ lib, pkgs, ... }:
pkgs.rustPlatform.buildRustPackage
{
  pname = "mdpls";
  version = "0-unstable";

  src = pkgs.fetchFromGitHub
  {
    owner = "euclio";
    repo = "mdpls";
    rev = "30761508593d85b5743ae39c4209947740eec92d";
    hash = "sha256-4n1MX8hS7JmKzaL8GfMq2q3IdwE4fvMmWOYo7rY+cdY=";
  };

  cargoHash = "sha256-Cw2rofmAFnyce2BnWOP/NcoOshxMURjhfoxVT61R1lU=";

  meta =
  {
    description = "Markdown preview language server";
    homepage = "https://github.com/euclio/mdpls";
    # license = lib.licenses.unfree;
    mainProgram = "mdpls";
  };
}
