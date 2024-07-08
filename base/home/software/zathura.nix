{ pkgs, ... }:

{
    programs.zathura =
    {
      options =
      {
        useMupdf = true;
      };
    };
}