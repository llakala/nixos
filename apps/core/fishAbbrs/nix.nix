{
  hm.programs.fish.shellAbbrs = {
    nd = "nix develop";
    nr = "nix run";
    ns = "nix shell";
    ne = "nix eval";

    nfu = "nix flake update";
    nfl = "nix flake lock";

    nrn = {
      setCursor = true;
      expansion = "nix run nixpkgs#%";
    };

    "nr." = {
      setCursor = true;
      expansion = "nix run .#%";
    };

    nsn = {
      setCursor = true;
      expansion = "nix shell nixpkgs#%";
    };


    "ns." = {
      setCursor = true;
      expansion = "nix shell .#%";
    };

    nrp = "nix repl";
    nrpn = "nix repl nixpkgs";
    nrpf = "nixos-rebuild repl";

    nba = "nix-build -A";

    ndr = "nix-direnv-reload";
  };
}
