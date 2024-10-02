{ lib, config, ... }:

{
  programs.yazi.enable = true;

  programs.yazi.settings.yazi = # yazi.toml settings, documented here https://yazi-rs.github.io/docs/configuration/yazi
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

  programs.yazi.settings.keymap =
  {
    manager.prepend_keymap = lib.singleton
    {
      on = ["g" "n"];
      run = "cd ${config.baseVars.configDirectory}";
      desc = "Go to the NixOS configuration directory";
    };
  };


}