# Basics
This directory describes the structure utilized in both the base folder, and any hosts you create. To ensure a host is properly imported, it should follow this structure. I also recommend making your own structure that follows your personal preferences.

## Passing your hostnames
Before you do anything, you'll have to tell mkHosts the usernames and hostnames for your given host.

NOTE: The username is only required right now due to extenuating personal circumstances, but this is silly, and in the future, only the hostname will be provided.

You can pass these through the flake.nix into mkHosts. A given host is then created by combining the base host and your personal host's provided configuration.

## Subdirectories

Any host is expected to provide these three directories, with a default.nix inside of it that imports all files located in the folder.

- [core](./base/core) manages basic functions you'd always want on a computer, like networking, the bootloader, etc.

- [os](./base/os) manages operating-system specific features.

- [software](./base/software) manages configurations for specific apps, like VSCode, Firefox, etc.

This structure is intended to work for both base and hosts. Hosts often don't specify that much, though, so it's very possible that many of these folders will be empty. This doesn't bother me, but if you dislike it, I recommend using a different structure for your base configuration and your hosts.

## Hardware configuration
All hosts should provide a hardware-configuration file along with the subdirectories above. This is to ensure that hardware-specific changes are taken into account, and you don't forget to include hardware-configuration somehow. This file can be generated automatically for your hardwarewith nixos-generate-config. I don't recommend heavily editing it unless you get an error saying filesystems are conflicting.

## Host variables
The last file expected to be provided is one that defines host variables. These are referenced within the base configuration for things that may  differ between hosts. Currently, the host variables aren't enforced (since I don't know how to do that), so it's expected that you provide all the ones it expects. This will hopefully be fixed at some point.

At the time of writing, you are expected to provide these host variables:
- hostName (example: nixos)
- username (example: user1)
- homeDirectory (example: /home/user1)
- fullName (example: Full Name)
- userEmail (example: awesomeperson@gmail.com)
