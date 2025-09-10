{ config, ... }:

let
  feats = config.features;
in {
  features.taskbar =
    assert feats.browser == "firefox";
    assert feats.files == "yazi";
    assert feats.terminal == "kitty";
    assert feats.usingKittab == true;
    assert feats.editor == "neovim";
    [
      "firefox.desktop"
      "yazi.desktop"
      "kittab.desktop"
      "nvim.desktop"
    ];

}
