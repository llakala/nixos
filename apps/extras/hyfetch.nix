{
  environment.shellAliases.neofetch = "hyfetch";

  hm.programs.hyfetch = {
    enable = true;
    settings = {
      preset = "transgender";
      mode = "rgb";
      color_align.mode = "horizontal";

      # Arguments passed into neofetch
      args = # bash
      ''
        --package_managers off
      '';
    };
  };
}
