{ lib, pkgs, ... }:

{
  services.pulseaudio.enable = lib.mkForce false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Fixes jack until https://github.com/NixOS/nixpkgs/issues/265128 is fixed
  environment.systemPackages = with pkgs; [
    pipewire.jack
  ];
}
