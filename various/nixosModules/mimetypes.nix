{ lib, config, ... }:

let
  cfg = config.custom.services.mimetypes;

  mkMimetypeOption = programDescription: lib.mkOption {
    type = lib.types.str;
    description = "The desktop entry for your ${programDescription} of choice";
    default = null;
  };
in {
  options.custom.services.mimetypes = {
    enable = lib.mkEnableOption "managing what apps are used for certain filetypes via the XDG specification";

    browser = mkMimetypeOption "browser";
    editor = mkMimetypeOption "text editor";
    fileManager = mkMimetypeOption "file manager";
    terminal = mkMimetypeOption "terminal";
    extractor = mkMimetypeOption "file extractor/archiver";

    imageViewer = mkMimetypeOption "image viewer";
    videoViewer = mkMimetypeOption "video viewer";
    pdfViewer = mkMimetypeOption "PDF viewer";
  };

  config = lib.mkIf cfg.enable {
    xdg.mime.enable = true;

    # NixOS stores these to /etc/xdg/mimeapps.list
    xdg.mime.defaultApplications = {
      "text/html" = cfg.browser;
      "text/xml" = cfg.browser;
      "x-scheme-handler/http" = cfg.browser;
      "x-scheme-handler/https" = cfg.browser;
      "x-scheme-handler/unknown" = cfg.browser;

      "text/*" = cfg.editor;
      "text/plain" = cfg.editor;
      "application/x-zerosize" = cfg.editor; # Empty files
      "application/x-trash" = cfg.editor; # Backup files
      "application/json" = cfg.editor;
      "text/markdown" = cfg.editor;

      "inode/directory" = cfg.fileManager;

      "application/*zip" = cfg.extractor;
      "application/gzip" = cfg.extractor;
      "application/rar" = cfg.extractor;
      "application/7z" = cfg.extractor;
      "application/*tar" = cfg.extractor;

      "image/*" = cfg.imageViewer;
      "video/*" = cfg.videoViewer;

      "application/pdf" = cfg.pdfViewer;
      "application/epub" = cfg.pdfViewer;
    };


    xdg.terminal-exec = {
      enable = true;
      settings.default = lib.singleton cfg.terminal;
    };
  };
}
