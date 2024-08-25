{ hostVars, ... }:

{

  programs.gh =
  {
    enable = true;
  };

  programs.gh.settings =
  {
    editor = hostVars.editor;
    git_protocol = "https"; # TODO: make this use ssh when proper secrets are set up
  };



}