# WHAT IS THIS?
This is my own nixos configuration for both my desktop and laptop. Currently it provides a base configuration, as well as per-host modules on top of the base.

# HOW IS IT ORGANIZED?
The current high-level structure is organized like this:

```
project
└───base
│   └───core
│   └───gnome
│   └───software
│   └───terminal
|   |   baseVars.nix
└───host1
│   └───core
│   └───gnome
│   └───software
│   └───terminal
|   |   host1Vars.nix
|   |   hardware-configuration.nix
└───host2
│   └───core
│   └───gnome
│   └───software
│   └───terminal
|   |   host2Vars.nix
|   |   hardware-configuration.nix
└───resources
│   └───overlays
│   └───documentation
|   |   shell.nix
│   flake.nix
│   mkHosts.nix
```

# DIVING DEEPER

## Facilitation
The flake.nix acts as our entrypoint, which declares our inputs and outputs. It utilizes a [function](./mkHosts.nix), which automatically creates hosts.

## Home-manager and nixos separation
This configuration utilizes home-manager, an extraordinarily useful tool for controlling parts of a user's home directory that don't already have options provided via base nixos. However, home-manager is an external project, and thus uses different options than the base NixOS. This means that a configuration requires separated directories to not cause issues.

The most frustrating part of this for me is that I never remember if something is a home file, or a nix one. To solve this, I have this separation at the lowest level. This means that if something isn't in the home directory, it'll be in the nix one right alongside it. I recommend adopting the same structure for your configuration.

## Structure
To simplify everything, I use a basic structure for both my base configuration and my hosts. This means that to be properly imported into the flake, a host should follow this structure. The base configuration can be thought of as its own host whose configuration is included in any other host.

The basic structure for a host is listed [here](./resources/documentation/structure.md).

## Variables
There are two types of variables: general variables, and host-specific variables. General variables are host-independent, such as the directory of the nixos configuration. Host-specific variables are set based on the host, like the hostname and email.

Files can request a value from hostVars without knowing which host is being used. For example, files in the base configuration can use values set in hostVars.

# HOW DO I USE THIS?

Well, you could install NixOS and clone the repo into your /etc/nixos directory. But I wouldn't recommend it, since most of the configuration is specific to my taste, which probably won't match yours. HOWEVER, I do think my configuration is pretty well organized, and a lot more readable than a lot of Nix code out there, which makes it appropriate for beginners. Because of this, I'd recommend fiddling around with it in a VM and seeing what parts of it you might want to adapt to your own tastes.