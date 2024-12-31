{
  hm.programs.fzf =
  {
    enable = true;

    defaultOptions = # Needs a reboot to apply
    [
      "--multi"
      "--exact"
      "--ansi"
      "--cycle"
      "--reverse"

      "--highlight-line"
      "--inline-info"
      "--border"
      "--no-separator"
    ];
  };
}
