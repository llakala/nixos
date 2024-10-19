{ lib, options, ... }:

{
  options.baseVars =
  {
    configDirectory = lib.mkOption
    {
      type = lib.types.str;
      description = "The directory of the local nixos configuration.";
      default = null;
    };

    editor = lib.mkOption
    {
      type = lib.types.str;
      description = "Your preferred text editor.";
      default = null;
    };
    fullName = lib.mkOption
    {
      type = lib.types.str;
      description = "Your first and last name.";
      default = null;
    };
  };

  config.assertions =
  [
    {
      assertion = options.baseVars.configDirectory.isDefined;
    }
    {
      assertion = options.baseVars.editor.isDefined;
    }
    {
      assertion = options.baseVars.fullName.isDefined;
    }
  ];
}
