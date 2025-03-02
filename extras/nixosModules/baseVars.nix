{ lib, options, ... }:

{
  options.baseVars =
  {
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

    email = lib.mkOption
    {
      type = lib.types.str;
      description = "Your email";
      default = null;
    };
  };

  config.assertions =
  [
    {
      assertion = options.baseVars.editor.isDefined;
    }
    {
      assertion = options.baseVars.fullName.isDefined;
    }
    {
      assertion = options.baseVars.email.isDefined;
    }
  ];
}
