{ adios }:
{
  options = {
    functions.default = ./functions;
    completions.default = ./completions;
    abbreviations.mutators = [ "/fish" "/gh" "/git" ];
    interactiveShellInit.mutators = [ "/fish" "/fzf" "/kitty" "/starship" "/yazi" "/zoxide" ];
  };

  mutations = {
    "/fish".abbreviations = _: import ./abbreviations.nix;
    "/fish".interactiveShellInit = _:  builtins.readFile ./config.fish;
  };
}
