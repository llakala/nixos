{ baseVars }:

# This file defines all my hosts, which are passed to `mkNixos` in the
# `outputs.nix` file. Each key defines the hostname, which points us to
# `extras/hosts/${hostname}` for extra host-specific config. Each value contains
# info about the system.
#
# `system` is an unfortunate necessity. You don't actually need to pass `system`
# to `lib.nixosSystem` - it'll already be defined within each host's
# `hardware-configuration.nix`. However, I have some functions which depend on
# system, that I want to inject into `specialArgs`. The only way to get around
# this would be `_module.args` abuse, so I'm fine to specify system here.
#
# `hostVars` gives us accessible data about the current host within our base
# configuration. This lets us inject something like the touchpad name directly
# into KDE config, while keeping the config system-independent and preventing
# duplication. I try to keep most of my config applicable to all hosts, so this
# is a great way of keeping that purity. Note that some hostVars are optional -
# not all hosts have a touchpad, for example, so as a consumer of the  vars, we
# make sure to use `lib.mkIf`. Most vars are required, though.
{
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
