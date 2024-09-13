{ vars, ... }:

{

  programs.gh =
  {
    enable = false;
  };

  programs.gh.settings =
  {
    editor = vars.editor;
    git_protocol = "https"; # TODO: make this use ssh when proper secrets are set up
  };



}