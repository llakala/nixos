{ ... }:


{

  programs.alacritty.enable = true;

  programs.alacritty.settings =
  {
    live_config_reload = true;

    window.title = "Terminal";

   font =
   {
      size = 12;
    };
    colors.draw_bold_text_with_bright_colors = true;
  };


}