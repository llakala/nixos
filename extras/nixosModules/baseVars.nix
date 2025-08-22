{ lib, ... }:

{
  options.baseVars = {
    username = lib.mkOption {
      type = lib.types.str;
      description = "The username for the current host.";
      default = null;
    };

    homeDirectory = lib.mkOption {
      type = lib.types.str;
      description = "The directory for the user's folders. This should only be set if it's in a non-default location.";
      default = null;
    };

    fullName = lib.mkOption {
      type = lib.types.str;
      description = "Your first and last name.";
      default = null;
    };

    email = lib.mkOption {
      type = lib.types.str;
      description = "Your email";
      default = null;
    };

    editor = lib.mkOption {
      type = lib.types.str;
      description = "Your preferred text editor.";
      default = null;
    };
  };
}
