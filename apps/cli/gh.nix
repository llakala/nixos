{ config, ... }:

{
  hm.programs.gh =
  {
    enable = true;

    settings =
    {
      editor = config.baseVars.editor;
      git_protocol = "https"; # TODO: make this use ssh when proper secrets are set up
    };
  };


}
