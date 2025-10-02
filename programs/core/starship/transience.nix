{ config, ... }:

{
  # Error if we ever stop using fish
  hm.programs.starship.enableTransience =
    assert config.features.shell == "fish"; true;

  hm.programs.fish.functions = {
    starship_transient_prompt_func = # fish
    ''
      echo # newline before horizontal line

      set_color "#44475A"
      printf '%.s─' $(seq $COLUMNS) && echo # Horizontal line followed by newline
      set_color normal

      starship module character
    '';

    starship_transient_rprompt_func = # fish
    ''
      starship module cmd_duration # Not currently working
    '';

  };
}
