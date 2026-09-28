_:
{
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
    abbreviations.mutators = [ "/fish" "/gh" "/git" ];
    interactiveShellInit.mutators = [ "/fish" "/fzf" "/kitty" "/starship" "/yazi" "/zoxide" ];
  };

  mutations = {
    "/fish".abbreviations = import ./abbreviations.nix;
    "/fish".interactiveShellInit = builtins.readFile ./config.fish;
  };
}
