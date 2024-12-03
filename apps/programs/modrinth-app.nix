{ pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs-unstable;
  [
    modrinth-app
  ];
}
