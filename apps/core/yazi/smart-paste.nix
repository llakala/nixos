{ lib, ... }:

{
  hm.programs.yazi.keymap.manager.prepend_keymap = lib.singleton
  {
    desc = "Paste into a directory if we're hovering over it";
    on = lib.singleton "p";
    run = "plugin smart-paste";
  };

  hm.xdg.configFile."yazi/plugins/smart-paste.yazi/main.lua".text =
  /* lua */
  ''
    --- @sync entry
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
