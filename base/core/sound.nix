{ lib, pkgs, ... }:

{
  sound.enable = true;
  hardware.pulseaudio.enable = lib.mkForce false;
  security.rtkit.enable = true;
  services.pipewire =
  {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  environment.systemPackages = with pkgs; # Fixes jack until https://github.com/NixOS/nixpkgs/issues/265128 is fixed
  [
    pipewire.jack
  ];
}