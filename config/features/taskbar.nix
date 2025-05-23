{ config, ... }:

let
  feats = config.features;
in
{
  features.taskbar =
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

}
