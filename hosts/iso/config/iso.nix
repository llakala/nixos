{ modulesPath, ... }:

{
  imports =
  [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal-new-kernel-no-zfs.nix"
  ];
}
