{ promise, ... }: {
  options = {
    completionsFiles.default = [
      ./completions/nix-build.fish
      ./completions/nix-shell.fish
    ];
    functionsFiles.default = [
      ./functions/cancel-or-commandline.fish
      ./functions/down-or-execute.fish
      ./functions/fish_user_key_bindings.fish
    ];
    abbreviations = {
      default = import ./abbreviations.nix;
      mutators = [
        "/gh"
        "/git"
      ];
    };
    interactiveShellInit = {
      default = promise.map (prev: ''
        ${prev}
        ${builtins.readFile ./config.fish}
      '');
      mutators = [
        "/fzf"
        "/kitty"
        "/starship"
        "/yazi"
        "/zoxide"
      ];
    };
  };
}
