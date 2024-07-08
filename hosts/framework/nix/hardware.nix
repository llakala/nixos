{ nixos-hardware, pkgs, pkgs-unstable, ...}:

{



  services =
  {
    fprintd.enable = true; # Fingerprint
    fstrim.enable = true; # Disk
  };

  services.power-profiles-daemon = # better power management
  {
    enable = true;
    package = pkgs-unstable.power-profiles-daemon.overrideAttrs
    (
      oldAttrs:
      {
        nativeBuildInputs = oldAttrs.nativeBuildInputs ++
        (with pkgs;
        [
          cmake
          pylint
          argparse-manpage
          bash-completion
        ]);
      }
    );
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
}