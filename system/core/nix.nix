{ hostVars, pkgs, config, ... }:

let
  setCursor = expansion: {
    setCursor = true;
    inherit expansion;
  };
in {
  nix.package = pkgs.lixPackageSets.latest.lix;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
      "no-url-literals"
    ];

    trusted-users = [
      "root"
      "@wheel" # Lets me use nix flakes that require nixConfig.
    ];

    connect-timeout = 5; # Offline caches won't just hang
    warn-dirty = false; # No warnings if git isn't pushed
    fallback = true; # If binary cache fails, it's okay

    keep-going = true; # If a derivation fails, build the others. We'll fix the failed one later
    max-jobs = "auto";

    allow-import-from-derivation = false;
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = hostVars.stateVersion;

  hm.programs.fish.shellAbbrs =
  assert config.features.abbreviations == "fish"; {
    nd = "nix develop";
    ne = "nix eval";

    nfu = "nix flake update";
    nfl = "nix flake lock";

    nr = "nix run";
    nrn = setCursor "nix run nixpkgs#%";
    "nr." = setCursor "nix run .#%";

    ns = "nix-shell";
    nsn = "nix-shell -p";

    "ns." = setCursor "nix shell .#%";

    nb = "nix-build";
    nba = "nix-build -A";
    nbn = "nix-build '<nixpkgs>' -A";

    "nb." = setCursor "nix build .#%";

    nrp = "nix repl";
    nrpn = "nix repl nixpkgs";
    nrpf = "nixos-rebuild repl";
  };
}
