{ lib, ... }:

{
  # exit the current mode if it exists, or quit Yazi if no mode is set
  # Nice QOL for yazi.nvim so I can easily exit, while also being able
  # to stop filtering/searching easily. Referenced from:
  # https://github.com/sxyazi/yazi/pull/1042
  # oh, and we also store the CWD on quit
  programs.yazi.plugins.escexit = ./escexit;

  programs.yazi.settings.keymap.manager.prepend_keymap = lib.singleton
  {
    desc = "Either exit the current menu, or quit Yazi and write the current directory to a file";
    on = "<Esc>";
    run = "plugin escexit";
  };
}
