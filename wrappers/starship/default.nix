{ promise, ... }: {
  options = {
    configFile.default = ./starship.toml;
    wrapperAttrs.mutators = [ "/git" ];
  };

  mutations = {
    "/fish".interactiveShellInit = promise (
      { options, inputs, result }:
      let
        inherit (inputs.nixpkgs) lib;
      in
      /* fish */ ''
        ${lib.getExe result} init fish | source
        enable_transience

        function starship_transient_prompt_func
          echo # newline before horizontal line

          set_color "#44475A"
          printf '%.s─' $(seq $COLUMNS) && echo # Horizontal line followed by newline
          set_color normal

          starship module character
        end

        function starship_transient_rprompt_func
          starship module cmd_duration
        end
      ''
    );
  };
}
