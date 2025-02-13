{ lib, config, ... }:

let
  cfg = config.custom.services.mimetypes;
in
{
  options.custom.services.mimetypes =
  {
    enable = lib.mkEnableOption "managing what apps are used for certain filetypes via the XDG specification";

    browser = lib.mkOption
    {
      type = lib.types.str;
      description = "The desktop entry for your browser of choice";
      default = null;
    };

    editor = lib.mkOption
    {
      type = lib.types.str;
      description = "The desktop entry for your text editor of choice";
      default = null;
    };

    terminal = lib.mkOption
    {
      type = lib.types.str;
      description = "The desktop entry for your terminal of choice.";
      default = null;
    };

    extractor = lib.mkOption
    {
      type = lib.types.str;
      description = "The desktop entry for your file extractor/archiver of choice.";
      default = null;
    };

    fileManager = lib.mkOption
    {
      type = lib.types.str;
      description = "The desktop entry for your file manager of choice.";
      default = null;
    };

    imageViewer = lib.mkOption
    {
      type = lib.types.str;
      description = "The desktop entry for your image viewer of choice.";
      default = null;
    };

    videoViewer = lib.mkOption
    {
      type = lib.types.str;
      description = "The desktop entry for your video viewer of choice.";
      default = null;
    };

    pdfViewer = lib.mkOption
    {
      type = lib.types.str;
      description = "The desktop entry for your PDF viewer of choice.";
      default = null;
    };


  };

  config = lib.mkIf cfg.enable
  {
    xdg.mime.enable = true;
    xdg.mime.defaultApplications =
    {
      "text/html" = cfg.browser;
      "text/xml" = cfg.browser;
      "x-scheme-handler/http" = cfg.browser;
      "x-scheme-handler/https" = cfg.browser;
      "x-scheme-handler/unknown" = cfg.browser;

      "text/*" = cfg.editor;
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


    xdg.terminal-exec =
    {
      enable = true;
      settings.default = lib.singleton cfg.terminal;
    };
  };
}
