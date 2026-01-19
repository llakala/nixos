{ adios }:
{
  options = {
    configFile.default = ./starship.toml;
    wrapperAttrs.mutators = [ "/git" ];
  };

  mutations = {
    "/fish".interactiveShellInit =
      { options, inputs }:
      let
        finalWrapper = options {};
        inherit (inputs.nixpkgs) lib;
      in
      /* fish */ ''
        ${lib.getExe finalWrapper} init fish | source
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
  };
}
