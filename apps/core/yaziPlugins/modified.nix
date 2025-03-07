{
  # My custom plugin to show only modified files
  # Core code logic from https://github.com/twio142/yazi-plugins/blob/81a5f92c4a089cd877ecf4101f48469a4e87c189/advanced-search.yazi/main.lua, massive thanks
  hm.programs.yazi.plugins.modified = ./modified;

  hm.programs.yazi.keymap.manager.prepend_keymap =
  [
    {
      on = "M";
      run = "plugin modified";
      desc = "Show all files that Git marks as modified within the current directory";
    }
  ];
}
