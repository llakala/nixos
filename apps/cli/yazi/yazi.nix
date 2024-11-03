{ lib, config, inputs, pkgs-unstable, myLib, ... }:

{
  imports = lib.singleton
  (
    myLib.mkUnstableHmModule
    {
      module = "programs/yazi.nix";
      moduleSource = inputs.home-manager-unstable;
    }
  );

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
