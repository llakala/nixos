{
  hm.programs.fish.shellAbbrs =
  {
    n = "nix";
    nd = "nix develop";
    nr = "nix run";
    ns = "nix shell";
    ne = "nix eval";
    nfu = "nix flake update";

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

    ndr = "nix-direnv-reload";
  };
}
