{ self, lib, ... }:

{
  features.prompt = "starship"; # If we ever stop using Starship, change this

  environment.systemPackages = [ self.wrappers.starship.drv ];

  programs.fish.interactiveShellInit = # fish
  ''
    ${lib.getExe self.wrappers.starship.drv} init fish | source
    enable_transience

    function starship_transient_prompt_func
      echo # newline before horizontal line

      set_color "#44475A"
      printf '%.s─' $(seq $COLUMNS) && echo # Horizontal line followed by newline
      set_color normal

      starship module character
    end


    # Not currently working
    function starship_transient_rprompt_func
      starship module cmd_duration
    end
  '';
}
