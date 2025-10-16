let
  sources = import ./various/npins;
  nixosSystem = import "${sources.nixpkgs}/nixos/lib/eval-config.nix";

  # Variables that apply to all hosts, for querying things like the username
  # without hardcoding it within config
  baseVars = import ./various/baseVars.nix;

  # Given some hostname and some additional parameters about the host, create a
  # lib.nixosSystem entrypoint for it.
  #
  # For some host `foo`, we auto-import some files from `extras/hosts/foo`. This
  # locks every host into providing a hardware configuration, as well as a
  # folder with generic extra config.
  #
  # You'll notice that `hostname` is taken separately from the rest of the
  # parameters. This is useful when calling `mkHost` with `builtins.mapAttrs`.
  # `mapAttrs` takes `{ key = value; }` and turns it into `key value`. This
  # allows us to interpret each host's key as its hostname, and its value as
  # extra parameters. Each host now doesn't have to redeclare its hostname in
  # the parameters - it's automatically inferred by the key!
  #
  # The parameters mainly consist of hostVars, which are autocally passed nto
  # `specialArgs`. This lets us handle slight differences between hosts. If two
  # hosts only differ by their scaling factor, we don't have to duplicate the
  # configuration - we just use the dynamic value of `hostVars.scalngFactor`! I
  # try to keep most of my config applicable to all hosts, so this is a great
  # way of keeping that purity.
  mkHost = hostname: { system, hostVars }: let
    pkgs = import sources.nixpkgs { inherit system; };
    myLib = import ./various/myLib/default.nix { inherit pkgs; };
  in nixosSystem {
    # Technically unnecessary, but keeps our impl pure
    inherit system;

    specialArgs = {
      inherit sources myLib baseVars;
      self.packages = import ./packages.nix { inherit pkgs sources; };

      # Use our inferred hostname from mapAttrs
      hostVars = hostVars // { inherit hostname; };
    };

    modules =
      # Any folders are automatically expanded to all the files within them
      myLib.recursivelyImport [
        ./programs
        ./system

        ./various/nixosModules

        ./various/hosts/${hostname}/config
        ./various/hosts/${hostname}/hardware-configuration.nix
      ] ++ myLib.getWrapperModules ./wrappers;
  };

in builtins.mapAttrs mkHost {
  desktop = {
    system = "x86_64-linux";

    hostVars = {
      mouseName = "Libinput/1133/16500/Logitech G305";
      scalingFactor = 1;

      configDirectory = "/home/${baseVars.username}/Documents/projects/nixos";
      stateVersion = "24.05";
    };
  };

  framework = {
    system = "x86_64-linux";

    hostVars = {
      scalingFactor = 2;

      configDirectory = "/etc/nixos";
      stateVersion = "24.05";
    };
  };

  palpot = {
    system = "x86_64-linux";

    hostVars = {
      scalingFactor = 1;
      touchpadName = "Libinput/1739/53227/PNP0C50:00 06CB:CFEB Touchpad";

      configDirectory = "/home/${baseVars.username}/Documents/projects/nixos";
      stateVersion = "25.05";
    };
  };

  iso = {
    system = "x86_64-linux";

    hostVars = {
      scalingFactor = 1;

      configDirectory = "/etc/nixos";
      stateVersion = "24.11";
    };
  };
}
