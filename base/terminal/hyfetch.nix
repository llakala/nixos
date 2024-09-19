{ ... }:

{
  hm =
  {
    programs.hyfetch =
    {
      enable = true;
      settings =
      {
        preset = "transgender";
        mode = "rgb";
        color_align.mode = "horizontal";

        args = ''
          --package_managers off
        ''; # Arguments passed into neofetch
      };
    };

    home.shellAliases.neofetch = "hyfetch";
  };
}