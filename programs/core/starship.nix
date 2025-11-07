{ self, lib, ... }:

{
  features.prompt = "starship"; # If we ever stop using Starship, change this

  environment.systemPackages = [ self.wrappers.starship.drv ];

  hm.programs.fish.interactiveShellInit = ''
    ${lib.getExe self.wrappers.starship.drv} init fish | source
    enable_transience
  '';

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
