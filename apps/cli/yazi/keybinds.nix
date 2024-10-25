{ pkgs, config, lib, ... }:
let
  wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy"; # We have it installed systemwide, but better safe than sorry
in
{
  hm.programs.yazi.keymap.manager.prepend_keymap =
  [
    {
      desc = "Open the selected files";
      on = lib.singleton "i"; # Same as "o" for open, but for my helix muscle memory
      run = "open";
    }
    {
      desc = "Go to the NixOS configuration directory";
      on = ["g" "n"];
      run = "cd ${config.baseVars.configDirectory}";
    }

    {
      desc = "Go to the projects folder for working on external Git repos";
      on = [ "g" "p" ];
      run = "cd ~/Documents/projects";
    }

    {
      desc = "Paste into the hovered directory or CWD";
      on = lib.singleton "p";
      run = "plugin --sync smart-paste";
    }

    {
      desc = "When copying, copy to the system clipboard as well";
      on = lib.singleton "y";
      run =
      [
        "yank"
        ''
          shell --confirm 'for path in "$@"; do echo "file://$path"; done | ${wl-copy} -t text/uri-list'
        ''
      ];
    }
  ];

  hm.xdg.configFile."yazi/plugins/smart-paste.yazi/init.lua".text = # lua
  ''
    return
    {
      entry = function()
        local h = cx.active.current.hovered
        if h and h.cha.is_dir then
          ya.manager_emit("enter", {})
          ya.manager_emit("paste", {})
          ya.manager_emit("leave", {})
        else
          ya.manager_emit("paste", {})
        end
      end,
    }
  '';
}
