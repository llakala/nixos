{ inputs, self }:
let
  inherit (inputs.nixpkgs) lib;

  # Variables that apply to all hosts, for querying things like the username
  # without hardcoding it within config
  baseVars = import ./various/baseVars.nix;

  # Given some hostname and some additional data about the host, creates it.
  #
  # There are a few things about this function that are important to note. First
  # of all, for any host `foo`, we auto-import some files from
  # `extras/hosts/foo`. This locks every host into providing a hardware
  # configuration, as well as a folder with generic extra config.
  #
  # Secondly, we do some parameter magic. You'll notice that `hostname` is taken
  # separately from the rest of the parameters. This may appear useless at
  # first, but it becomes useful when calling `mkNixos` with `builtins.mapAttrs`.
  #
  # Now, `mapAttrs` is very simple: it takes `{ key = value; }` and turns it
  # into `key value`. But this is specifically useful for our case, because it
  # lets us understand each host's key as its hostname, and its value as extra
  # parameters.
  #
  # Take this example host:
  #
  # foo = {
  #   param1 = "hi";
  #   param2 = "bye!"
  # };
  #
  # `mapAttrs` turns this into:
  #
  # "foo" { param1 = "hi"; param2 = "bye"; }
  #
  # This means we don't have to redeclare what the hostname is in the parameters
  # - it's automatically inferred by the key!
  #
  # Finally, note that every host declares some set of hostVars, which are
  # autocally passed nto `specialArgs`. This lets us handle slight differences
  # between hosts. If two hosts only differ by their scaling factor, we don't
  # have to duplicate the configuration - we just use the dynamic value of
  # `hostVars.scalngFactor`! I try to keep most of my config applicable to all
  # hosts, so this is a great way of keeping that purity.
  mkNixos = hostname: { system, hostVars }: let
    pkgs = inputs.nixpkgs.legacyPackages.${system};
    myLib = import ./various/myLib/default.nix { inherit pkgs; };
  in lib.nixosSystem {
    specialArgs = {
      inherit inputs myLib self baseVars;

      # Use our inferred hostname from mapAttrs
      hostVars = hostVars // { inherit hostname; };
    };

    modules = myLib.recursivelyImport [
      ./programs
      ./system

      ./various/nixosModules

      ./various/hosts/${hostname}/config
      ./various/hosts/${hostname}/hardware-configuration.nix
    ];
  };

in builtins.mapAttrs mkNixos {
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
