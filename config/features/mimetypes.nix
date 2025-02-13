{ config, ... }:

let
  feats = config.features;
in
{
  custom.services.mimetypes =
  {
    enable = true;

    browser =
      assert feats.browser == "firefox";
      "firefox.desktop";

    editor =
      assert feats.editor == "neovim";
      "nvim.desktop";

    fileManager =
      assert feats.fileManager == "yazi";
      "yazi.desktop";

    terminal =
      assert feats.terminal == "kitty";
      assert feats.usingKittab == true;
      "kittab.desktop";

    pdfViewer =
      assert feats.pdfViewer == "evince";
      "org.gnome.Evince.desktop";

    # Reusing file manager for extraction
    extractor =
      assert feats.fileManager == "yazi";
      "yazi.desktop";

    imageViewer =
      assert feats.imageViewer == "loupe";
      "org.gnome.Loupe.desktop";

    videoViewer =
      assert feats.videoViewer == "totem";
      "org.gnome.Totem.desktop";
  };

}
