{ config, ... }:

{
  hm.programs.starship.enableTransience =

    # Error if we ever stop using fish
    assert config.features.shell == "fish";
    true;

  hm.programs.fish.functions =
  {
    starship_transient_prompt_func =
    /* fish */
    ''

      # newline before horizontal line
      echo

      set_color "#44475A"

      # Horizontal line followed by newline
      printf '%.s─' $(seq $COLUMNS) && echo
      set_color normal

      starship module character
    '';

    starship_transient_rprompt_func =
    /*fish */
    ''

      # Not currently working
      starship module cmd_duration
    '';

  };
}
