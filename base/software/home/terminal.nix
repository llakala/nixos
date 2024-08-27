{ ... }:


{

  programs.kitty =
  {
    enable = true;
    shellIntegration.enableZshIntegration = true;

    font.name = "JetBrains Mono";
    theme = "Catppuccin-Mocha";
  };

  programs.kitty.settings =
  {
    linux_display_server = "x11"; # Make titlebar work normally
  };


}