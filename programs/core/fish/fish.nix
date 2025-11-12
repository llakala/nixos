{ pkgs, ... }:

{
  features.shell = "fish"; # If we ever stop using Fish, change this
  features.abbreviations = "fish";

  programs.command-not-found.enable = false; # Broken

  hm.programs.fish.enable = true;
  hm.xdg.configFile."fish/config.fish".force = true;

  users.defaultUserShell = pkgs.fish;
  programs.fish = {
    enable = true;
    useBabelfish = true; # Important: halves the startup time
    interactiveShellInit = builtins.readFile ./config.fish;

    shellAbbrs = {
      m = "man";
      py = "python";
      j = "java";

      src = "source";
    };
  };

  hm.xdg.configFile."fish/functions/down-or-execute.fish".source = ./down-or-execute.fish;
}
