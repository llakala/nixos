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

    abbreviationsProvider = lib.mkOption
    {
      type = lib.types.str;
      description = "The chosen provider of abbrevations";
      default = null;
    };
  };
}
