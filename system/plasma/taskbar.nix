{ lib, config, ... }:

let
  feats = config.features;
in {
  hm.programs.plasma.panels = lib.singleton {
    location = "bottom";
    widgets = [
      {
        kickoff.icon = "nix-snowflake-white";
      }
      {
        iconTasks.launchers =
          assert feats.browser == "firefox";
          assert feats.files == "yazi";
          assert feats.terminal == "kitty";
          assert feats.usingKittab == true;
          assert feats.editor == "neovim";
          map (item: "applications:" + item) [
            "firefox.desktop"
            "yazi.desktop"
            "kittab.desktop"
            "nvim.desktop"
          ];
      }
      "org.kde.plasma.marginsseparator"
      {
        systemTray.items = {
          shown = [
            "org.kde.plasma.battery"
            "org.kde.plasma.clipboard"
            "org.kde.plasma.networkmanagement"
          ];
          hidden = [
            "org.kde.plasma.brightness"
            "org.kde.plasma.volume"
          ];
        };
      }
      "org.kde.plasma.digitalclock"
    ];
  };
}
