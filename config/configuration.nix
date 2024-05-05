# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
inputs,
pkgs,
pkgs-unstable,
config,
...
}:

{
  imports =
  [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Important settings, never to change
  nix.settings.experimental-features = "nix-command flakes";
  virtualisation.vmware.host.enable = true;



  users.users.username =
  {
    isNormalUser = true;
    description = "User Name";
    password = " ";
    extraGroups = [ "networkmanager" "wheel" ];
  };
  security.sudo.wheelNeedsPassword = false;

# Packages for terminal
nixpkgs.config.allowUnfree = true;

environment.sessionVariables.FLAKE = "/etc/nixos";
environment.systemPackages =
(with pkgs;
[
  libsecret
  busybox # Tiny utils
  libgccjit # gcc
  linuxKernel.packages.linux_xanmod_stable.system76 # dkms command
  gnumake # make command
  nodejs
  git
  efibootmgr # manage efi entries
  grub2_efi # grub commands
  gparted
])
++

(with pkgs-unstable;
[
  nh
]);

  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire =
  {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  networking =
  {
    hostName = "mypc";
    networkmanager.enable = true;

    firewall.enable = true;
    resolvconf.dnsExtensionMechanism = false;
  };


  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "23.11"; # Did you read the comment?

  }
