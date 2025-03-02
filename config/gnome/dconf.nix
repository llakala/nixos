{ config, ... }:

let
  feats = config.features;
in
{
  hm.dconf.settings =
  {
    "org/gnome/shell" =
    {
      favorite-apps = # Taskbar apps
      assert feats.browser == "firefox";
      assert feats.files == "yazi";
      assert feats.terminal == "kitty";
      assert feats.usingKittab == true;
      assert feats.editor == "neovim";
      assert feats.discord == "vesktop";
      assert feats.math == "obsidian";
      [
        "firefox.desktop"
        "yazi.desktop"
        "kittab.desktop"
        "nvim.desktop"
        "vesktop.desktop"
        "obsidian.desktop"
       ];
    };


    "org/gnome/desktop/interface" =
    {
      color-scheme = "prefer-dark";

      clock-format = "12h";
      clock-show-weekday = true; # Show day of the week on top bar
      clock-show-date = false; # Don't show the date


      enable-hot-corners = false;
      font-antialiasing = "rgba"; # Aliasing with lcd screen instead of grayscale

    };

    "org/gnome/settings-daemon/plugins/power" =
    {
      ambient-enabled = false;
    };

    "org/gnome/desktop/wm/preferences" =
    {
      num-workspaces = 1;
      button-layout = "appmenu:minimize,close"; # Show minimize and close button for windows
      action-right-click-titlebar = "toggle-shade";
    };

    "org/gnome/mutter" =
    {
      dynamic-workspaces = false;
    };


    "org/gnome/desktop/privacy" =
    {
      remove-old-temp-files = true;
      recent-files-max-age = 30;

      remove-old-trash-files = true;
      old-files-age = 30;
    };


    "org/gnome/desktop/peripherals/mouse" =
    {
      accel-profile = "flat"; # No mouse acceleration
      speed = -0.50969;
    };

    "org/gnome/desktop/peripherals/touchpad" =
    {
      accel-profile = "flat";
      disable-while-typing = false;
    };


    "org/gtk/settings/file-chooser" =
    {
      clock-format = "12h";
    };


  };
}
