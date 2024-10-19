{ lib, config, ... }:
let
  cfg = config.custom.services.mimetypes;
  # allPackages = config.environment.systemPackages ++ config.home-manager.users.${config.hostVars.hostname}.home.packages; # We assume hostVars exists, but that shouldn't be a problem
  # packageExists = package: builtins.elem package allPackages;
in
{
  options.custom.services.mimetypes =
  {
    enable = lib.mkEnableOption "managing what apps are used for certain filetypes via the XDG specification";

    browser = lib.mkOption
    {
      type = lib.types.str;
      description = "The desktop entry for your browser of choice";
    };

    editor = lib.mkOption
    {
      type = lib.types.str;
      description = "The desktop entry for your text editor of choice";
    };

    terminal = lib.mkOption
    {
      type = lib.types.str;
      description = "The desktop entry for your terminal of choice.";
    };

    extractor = lib.mkOption
    {
      type = lib.types.str;
      description = "The desktop entry for your file extractor/archiver of choice.";
    };

    fileManager = lib.mkOption
    {
      type = lib.types.str;
      description = "The desktop entry for your file manager of choice.";
    };

    imageViewer = lib.mkOption
    {
      type = lib.types.str;
      description = "The desktop entry for your image viewer of choice.";
    };

    videoViewer = lib.mkOption
    {
      type = lib.types.str;
      description = "The desktop entry for your video viewer of choice.";
    };

    pdfViewer = lib.mkOption
    {
      type = lib.types.str;
      description = "The desktop entry for your PDF viewer of choice.";
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


    xdg.terminal-exec.enable = true; # From NixOS xdg module, not Home-Manager one
    xdg.terminal-exec.settings.default = lib.singleton cfg.terminal;
  };
}
