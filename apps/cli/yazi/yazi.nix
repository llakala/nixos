{ lib, config, inputs, pkgs-unstable, ... }:

{
  hm = # Use unstable home-manager module for yazi
  {
    disabledModules = lib.singleton "${inputs.home-manager}/modules/programs/yazi.nix";
    imports = lib.singleton "${inputs.home-manager-unstable}/modules/programs/yazi.nix";
  };

  hm.programs.yazi =
  {
    enable = true;
    package = pkgs-unstable.yazi;
  };

  hm.programs.yazi.settings.opener.edit = # Custom options when opening a file
  [
    {
      run = ''${config.baseVars.editor} "$@" '';
      desc = "Open with the default editor.";
      block = true;
    }
  ];

}
