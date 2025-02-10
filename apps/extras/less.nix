{
  programs.less =
  {
    enable = true;
    envVariables.LESS = "--RAW-CONTROL-CHARS --wordwrap";
  };

  # Requires relog to apply
  programs.less.commands =
  {
    h = "left-scroll";
    l = "right-scroll";
  };
}
