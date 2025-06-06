{
  programs.less =
  {
    enable = true;

    # -+F always uses the pager, even if the text can fit on the whole screen.
    envVariables.LESS = "--RAW-CONTROL-CHARS --wordwrap --clear-screen -+F";
  };

  # Requires relog to apply
  programs.less.commands =
  {
    h = "left-scroll";
    l = "right-scroll";
  };
}
