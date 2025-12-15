{ adios }:
let
  inherit (adios) types;
in {
  name = "starship";

  inputs = {
    nixpkgs.path = "/nixpkgs";
    git.path = "/git";
  };

  options = {
    configFile = {
      type = types.path;
      default = ./starship.toml;
    };
  };

  mutations."/fish".interactiveShellInit =
    { options, inputs }:
    let
      finalWrapper = options { };
      inherit (inputs.nixpkgs) lib;
    in
    # fish
    ''
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

  impl =
    { options, inputs }:
    let
      inherit (inputs.nixpkgs) pkgs;
      inherit (pkgs) symlinkJoin makeWrapper;
    in
    symlinkJoin {
      name = "starship-wrapped";
      paths = [ pkgs.starship ];
      buildInputs = [ makeWrapper ];
      postBuild = /* bash */ ''
        wrapProgram $out/bin/starship \
          --set STARSHIP_CONFIG ${options.configFile} \
          --set XDG_CONFIG_HOME ${inputs.git.configDir} # Makes starship follow /git/ignore for git status module
      '';
      meta.mainProgram = "starship";
    };
}
