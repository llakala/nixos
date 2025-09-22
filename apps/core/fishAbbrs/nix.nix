{
  hm.programs.fish.shellAbbrs = {
    nd = "nix develop";
    ne = "nix eval";

    nfu = "nix flake update";
    nfl = "nix flake lock";

    nr = "nix run";
    nrn = {
      setCursor = true;
      expansion = "nix run nixpkgs#%";
    };
    "nr." = {
      setCursor = true;
      expansion = "nix run .#%";
    };

    ns = "nix shell";
    nsn = {
      setCursor = true;
      expansion = "nix shell nixpkgs#%";
    };
    "ns." = {
      setCursor = true;
      expansion = "nix shell .#%";
    };

    nb = "nix build";
    nba = "nix-build -A";
    nbn = {
      setCursor = true;
      expansion = "nix build nixpkgs#%";
    };
    "nb." = {
      setCursor = true;
      expansion = "nix build .#%";
    };

    nrp = "nix repl";
    nrpn = "nix repl nixpkgs";
    nrpf = "nixos-rebuild repl";

    ndr = "nix-direnv-reload";
  };
}
