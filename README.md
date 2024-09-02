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
│   └───documentation
|   |   shell.nix
│   flake.nix
│   mkHosts.nix
```

# DIVING DEEPER

## Facilitation
The flake.nix utilizes a [function](./mkHosts.nix), which automatically creates hosts. This means that you can create a new host via the file structure without having to write a config for it in the flake!

## Home-manager and nixos separation
This configuration utilizes home-manager, which you've likely heard of before if you're reading this. However, home-manager is an external project, and thus uses different options than the base NixOS. This means that a configuration requires separated directories to not cause issues.

The most frustrating part of this for me is that I never remember if something is a home file, or a nixos one. To solve this, I have this separation at the lowest level. This means that if something isn't in the home directory, it'll be in the nixos one right alongside it. I recommend adopting the same structure for your configuration.

## Structure
To simplify everything, I use a basic structure for both my base configuration and my hosts. This means that to be properly imported into the flake, a host should follow this structure. The base configuration can be thought of as its own host whose configuration is included in any other host.

The basic structure for a host is listed [here](./resources/documentation/structure.md).

## Variables
There are two types of variables: general variables, and host-specific variables. General variables are host-independent, such as the directory of the nixos configuration. Host-specific variables are set based on the host, like the hostname and email.

Files can request a value from hostVars without knowing which host is being used. For example, files in the base configuration can use values set in hostVars.

# HOW DO I USE THIS?

Just kidding. Nobody actually uses a random person's NixOS configuration. Unless it's Misterio's and you want to cause yourself pain and suffering.

Anyways, I think this is a pretty good reference. I try to keep things readable and well-commented so everything is reproducible for a casual observer. Here's a quick list of things you should steal from me:

- My rebuild function is awesome. I wrote some really cool logic with `rbld -f`, so it gets flake updates, then checks whether those flake updates necessitate a rebuild. Check it out [here](./base/terminal/home/shellextras/rbld.sh).

- I have a cool little import function that imports all *.nix files in a folder, without the need for a default.nix file. Check it out [here](mkHosts.nix).

- I have a lot of software that I've heavily configured, like Firefox, Kitty, Gnome extensions, etc. Steal it all! I think it looks pretty, which makes it objectively the best configuration out there.

Thanks for reading! I hope this helps you as a resource.