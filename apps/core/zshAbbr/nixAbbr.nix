{
  hm.programs.zsh.zsh-abbr.abbreviations = 
  {
    n = "nix";
    nd = "nix develop";
    nr = "nix run";

    nrn = "nix run nixpkgs#%";
    "nr." = "nix run .#%";
    nsn = "nix shell nixpkgs#%";

    nrp = "nix repl";
    nrpn = "nix repl nixpkgs";
    nrpf = "nixos-rebuild repl";
  };
}