{ vars, ... }:
{
  imports =
  [
    (fetchTarball "https://github.com/nix-community/nixos-vscode-server/tarball/master")
  ];

services.vscode-server =
{
  enable = true;
  enableFHS = true;
  installPath = "$HOME/.vscode-server";
};

}