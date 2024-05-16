-{ vars, ... }:
{
  imports =
  [
    (fetchTarball
    {
      url = "https://github.com/nix-community/nixos-vscode-server/tarball/master";
      sha256 = "sha256:1rq8mrlmbzpcbv9ys0x88alw30ks70jlmvnfr2j8v830yy5wvw7h";
    } )
  ];

services.vscode-server =
{
  enable = true;
  enableFHS = true;
  installPath = "$HOME/.vscode-server";
};

}