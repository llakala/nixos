{ inputs, pkgs, ...}:

{
  imports =
  [
     inputs.nixos-hardware.nixosModules.framework-13-7040-amd
  ];


  hardware.graphics =
  {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs;
    [
      libvdpau-va-gl
      vaapiVdpau
    ];
  };


  custom.hardware.framework-laptop.keyboardBacklight =
  {
    enable = true;
    brightness = 0;
  };
  custom.hardware.framework-laptop.fingerprintBacklight =
  {
    enable = true;
    brightness = "medium";
  };


  services =
  {
    fstrim.enable = true; # Disk
  };

  services.fwupd = # Bios updates
  {
    enable = true;
    extraRemotes = [ "lvfs-testing" ];
  };


  hardware.wirelessRegulatoryDatabase = true; # Speed up wifi?
  boot.extraModprobeConfig =
  ''
    options cfg80211 ieee80211_regdom="US"
  '';


  # boot.kernelPatches =
  # [
  #   {
  #     # Until next kernel, use this for battery according to https://community.frame.work/t/guide-fw13-ryzen-power-management/42988/68
  #     patch = pkgs.fetchpatch2
  #     {
  #       name = "amdgpu-vcn-1.diff";
  #       url = "https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/rawdiff/?h=superm1/vcn-dpg-6.9&id=13b322789fae1d6a1fad2c09887fbd9c25ecddc4";
  #       hash = "sha256-Apf+jhlaLf9+AbLxJ1yWb2Ka5b3OfIV3gNIqnfnNwho=";
  #     };
  #   }

  #   {
  #     patch = pkgs.fetchpatch2
  #     {
  #       name = "amdgpu-vcn-2.diff";
  #       url = "https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/rawdiff/?h=superm1/vcn-dpg-6.9&id=c6b76db6ce46eab7d186b68b5ed4bea4d3800161";
  #       hash = "sha256-yZ9p/G/YMlreloF3Cq9dsshO1Oomj6+IVJkl/TH0/VE=";
  #     };
  #   }

  # ];
}