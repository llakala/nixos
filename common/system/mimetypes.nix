{ config, ... }:

let
  feats = config.features;
in {
  custom.services.mimetypes = {
    enable = true;

    browser =
      assert feats.browser == "firefox";
      "firefox.desktop";

    editor =
      assert feats.editor == "neovim";
      "nvim.desktop";

    fileManager =
      assert feats.files == "yazi";
      "yazi.desktop";

    terminal =
      assert feats.terminal == "kitty";
      assert feats.usingKittab == true;
      "kittab.desktop";

    pdfViewer =
      assert feats.pdfs == "firefox";
      "firefox.desktop";

    # Reusing file manager for extraction
    extractor =
      assert feats.files == "yazi";
      "yazi.desktop";

    imageViewer =
      assert feats.images == "loupe";
      "org.gnome.Loupe.desktop";

    videoViewer =
      assert feats.videos == "totem";
      "org.gnome.Totem.desktop";
  };

}
