{ lib, config, ... }:

{
  options.features =
  {

    shell = lib.mkOption
    {
      type = lib.types.str;
      description = "The primary shell, which provides some form of initExtra access";
      default = null;
    };

    desktop = lib.mkOption
    {
      type = lib.types.str;
      description = "The chosen desktop environment";
      default = null;
    };

    prompt = lib.mkOption
    {
      type = lib.types.str;
      description = "The chosen shell prompt";
      default = null;
    };

    editor = lib.mkOption
    {
      type = lib.types.str;
      description = "The chosen editor";
      default = null;
    };

    abbreviations = lib.mkOption
    {
      type = lib.types.str;
      description = "The chosen provider of abbrevations";
      default = null;
    };

    direnv = lib.mkOption
    {
      type = lib.types.str;
      description = "The chosen program for accessing direnv functionality";
      default = null;
    };

    browser = lib.mkOption
    {
      type = lib.types.str;
      description = "The chosen browser";
      default = null;
    };

    terminal = lib.mkOption
    {
      type = lib.types.str;
      description = "The chosen terminal";
      default = null;
    };

    fileManager = lib.mkOption
    {
      type = lib.types.str;
      description = "The chosen file manager";
      default = null;
    };

    pdfViewer = lib.mkOption
    {
      type = lib.types.str;
      description = "The chosen PDF viewer";
      default = null;
    };

    imageViewer = lib.mkOption
    {
      type = lib.types.str;
      description = "The chosen image viewer";
      default = null;
    };

    videoViewer = lib.mkOption
    {
      type = lib.types.str;
      description = "The chosen video viewer";
      default = null;
    };

    usingKittab = lib.mkOption
    {
      type = lib.types.bool;
      description = "Whether kittab is setup and being used.";
      default = false;
    };

  };
}
