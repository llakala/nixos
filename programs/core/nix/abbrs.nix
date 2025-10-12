{ config, ... }:

let
  # Cursor refers to your actual cursor, not the AI tool, I promise
  setCursor = expansion: {
    setCursor = true;
    inherit expansion;
  };

in {
  hm.programs.fish.shellAbbrs =
  assert config.features.abbreviations == "fish"; {
    nd = "nix develop";
    ne = "nix eval";

    nfu = "nix flake update";
    nfl = "nix flake lock";

    nr = "nix run";
    nrn = setCursor "nix run nixpkgs#%";
    "nr." = setCursor "nix run .#%";

    ns = "nix shell";
    nsn = setCursor "nix shell nixpkgs#%";
    "ns." = setCursor "nix shell .#%";

    nb = "nix build";
    nba = "nix-build -A";
    nbn = setCursor "nix build nixpkgs#%";
    "nb." = setCursor "nix build .#%";

    nrp = "nix repl";
    nrpn = "nix repl nixpkgs";
    nrpf = "nixos-rebuild repl";

    ndr = "nix-direnv-reload";
  };
}
