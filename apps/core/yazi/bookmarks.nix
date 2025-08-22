{ config, ... }:

{
  hm.programs.yazi.keymap.mgr.prepend_keymap = [
    # Remove the default bookmarks for home and downloads, since we use `b` instead
    {
      on = ["g" "h"];
      run = "noop";
    }
    {
      on = ["g" "d"];
      run = "noop";
    }
    {
      on = ["g" "c"];
      run = "noop";
    }

    {
      on = [ "b" "h" ];
      run = "cd ~";
      desc = "Go home";
    }
    {
      on = [ "b" "d" ];
      run = "cd ~/Downloads";
      desc = "Goto ~/Downloads";
    }

    {
      desc = "Go to the NixOS configuration directory";
      on = ["b" "n"];
      run = "cd ${config.hostVars.configDirectory}";
    }

    {
      desc = "Go to the projects folder for working on my personal repos";
      on = [ "b" "p" ];
      run = "cd ~/Documents/projects";
    }
    {

      desc = "Go to the classes directory for working on homework";
      on = [ "b" "c" ];
      run = "cd ~/Documents/classes";
    }

    {
      desc = "Go to the repos directory for working on external Git repos";
      on = [ "b" "r" ];
      run = "cd ~/Documents/repos";
    }
  ];
}
