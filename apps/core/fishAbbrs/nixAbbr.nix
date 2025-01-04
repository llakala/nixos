{
  hm.programs.fish.shellAbbrs =
  {
    n = "nix";
    nd = "nix develop";
    nr = "nix run";

    nrn =
    {
      setCursor = true;
      expansion = "nix run nixpkgs#%";
    };

    "nr." =
    {
      setCursor = true;
      expansion = "nix run .#%";
    };

    nsn =
    {
      setCursor = true;
      expansion = "nix shell nixpkgs#%";
    };

    nrp = "nix repl";
    nrpn = "nix repl nixpkgs";
    nrpf = "nixos-rebuild repl";
  };
}