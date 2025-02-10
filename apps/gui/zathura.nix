{
  hm.programs.zathura =
  {
    enable = true;
    options =
    {
      useMupdf = true;

      selection-clipboard = "clipboard"; # Use system keyboard so ctrl+c and ctrl+v work
      guioptions = "vcs"; # Show vertical scrollbar, command line interface, and status bar

      statusbar-home-tilde = true; # Use ~ instead of /home
      smooth-scroll = true;
    };
  };
}
