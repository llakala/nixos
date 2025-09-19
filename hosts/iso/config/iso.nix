{ modulesPath, lib, ... }:

{
  # Compile ISO with `nix build .#nixosConfigurations.iso.config.system.build.isoImage`
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-calamares.nix"
  ];

  boot.supportedFilesystems.zfs = lib.mkForce false;
  # faster compression, even if file is bigger
  isoImage.squashfsCompression = "gzip -Xcompression-level 1";
}
