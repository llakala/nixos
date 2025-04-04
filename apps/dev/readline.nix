{
  hm.programs.readline =
  {
    enable = true;

    bindings =
    {
      "\\t" = "menu-complete";
      "\\e[Z" = "menu-complete-backward";
      "\\C-w" = "backward-kill-word";
    };

    variables =
    {
      editing-mode = "vi";
      show-mode-in-prompt = true;

      enable-bracketed-paste = true;
    };
  };
}
