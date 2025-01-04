{
    hm.programs.starship.enableTransience = true;

    hm.programs.fish.functions =
    {
      starship_transient_prompt_func =
      /* fish */
      ''
        echo
        starship module character
      '';

      starship_transient_rprompt_func =
      /*fish */
      ''
        starship module cmd_duration
      '';

    };
}