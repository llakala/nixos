{ lib, ... }:

let
  # exit the current mode if it exists, or quit Yazi if no mode is set
  # Nice QOL for yazi.nvim so I can easily exit, while also being able
  # to stop filtering/searching easily. Referenced from:
  # https://github.com/sxyazi/yazi/pull/1042
  # oh, and we also store the CWD on quit
  escexit =
  /* lua */
  ''
    --- @sync entry
    return {
      entry = function()
        local active = cx.active
        local current = active.current

        #active.selected > 0 or current.files.filter or current.cwd.is_search
        local esc = active.mode.is_visual or

        if esc then
          ya.manager_emit("escape", {})
        else
          local cwd = tostring(current.cwd)
          local file = io.open('/tmp/yazi-cwd-suspend', 'w')

          if file then
            file:write(cwd)
            file:close()
          end
          ya.manager_emit("quit", {})
        end
      end,
    }
  '';
in
{
  hm.xdg.configFile =
  {
    "yazi/plugins/escexit.yazi/main.lua".text = escexit;
  };

  hm.programs.yazi.keymap.manager.prepend_keymap = lib.singleton
  {
    desc = "Either exit the current menu, or quit Yazi and write the current directory to a file";
    on = "<Esc>";
    run = "plugin escexit";
  };
}
