{ lib, config, pkgs-unstable, inputs, ... }:

{

  hm = 
  {
    disabledModules = lib.singleton "${inputs.home-manager}/modules/programs/yazi.nix";
    imports = lib.singleton "${inputs.home-manager-unstable}/modules/programs/yazi.nix";
  };


  
  hm.programs.yazi =
  {
    enable = true;
    # package = pkgs-unstable.yazi; # Can't use until I fix missing folder icon
  };

  hm.programs.yazi.settings = # yazi.toml settings, documented here https://yazi-rs.github.io/docs/configuration/yazi
  {
    opener.edit =
    [
      {
        run = ''${config.baseVars.editor} "$@" '';
        desc = "Open with the default editor.";
        block = true;
      }

      {
        run = ''code "$@" '';
        desc = "Open with VSCode.";
        block = true;
      }
    ];
  };

  hm.programs.yazi.keymap.manager.prepend_keymap =
  [
    {
      on = lib.singleton "i"; # Same as "o" for open, but for my helix muscle memory
      run = "open";
      desc = "Open the selected files";
    }
    {
      on = ["g" "n"]; # g+n in sequence
      run = "cd ${config.baseVars.configDirectory}";
      desc = "Go to the NixOS configuration directory";
    }
  ];


}
