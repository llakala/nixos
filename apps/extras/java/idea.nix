{ pkgs-unstable, lib, ... }:

let
  program = pkgs-unstable.jetbrains.idea-community;

  plugins =
  [
     "ideavim"
  ];

  programAndPlugins = pkgs-unstable.jetbrains.plugins.addPlugins program
    plugins;

in
{
  environment.systemPackages = lib.singleton programAndPlugins;

  hm.home.file.".ideavimrc".source = ./.ideavimrc;
  hm.home.file.".ideavimrc".force = true;
}