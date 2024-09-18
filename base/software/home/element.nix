{ pkgs, lib, ... }:

{



  home.packages = with pkgs;
  [
    element-desktop
  ];

  # Fix errors with read-only file system before bringing back
  # home.file.".config/Element/electron-config.json".text = builtins.toJSON
  # {
  #   locale = lib.singleton "en";
  #   warnBeforeExit = false;
  # };

  home.file.".config/Element/config.json".text = builtins.toJSON
  {
    default_theme = "dark";
  };



}