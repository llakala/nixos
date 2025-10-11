{ myLib, sources, ... }:

let
  modulesPath = "${sources.home-manager}/modules";
in {
  home-manager.minimal = true;

  hm.imports = myLib.recursivelyImport [
    "${modulesPath}/programs/emacs.nix" # Used by jujutsu module

    "${modulesPath}/programs/bat.nix"
    "${modulesPath}/programs/firefox"
    "${modulesPath}/programs/fish.nix"
    "${modulesPath}/programs/gh.nix"
    "${modulesPath}/programs/git.nix"
    "${modulesPath}/programs/home-manager.nix"
    "${modulesPath}/programs/jujutsu.nix"
    "${modulesPath}/programs/kitty.nix"
    "${modulesPath}/programs/man.nix"
    "${modulesPath}/programs/readline.nix"
    "${modulesPath}/programs/ripgrep.nix"
    "${modulesPath}/programs/starship.nix"
    "${modulesPath}/programs/yazi.nix"
    "${modulesPath}/programs/zathura.nix"
    "${modulesPath}/programs/zoxide.nix"
  ];
}
