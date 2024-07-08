{ nixos-hardware, pkgs, ...}:

{



  services =
  {
    fprintd.enable = true; # Fingerprint
    auto-cpufreq.enable = true;
    fstrim.enable = true;
  };

  services.power-profiles-daemon = # better power management
  {
    enable = true;
    package = pkgs.power-profiles-daemon.overrideAttrs
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
        src = pkgs.fetchFromGitLab
        {
          domain = "gitlab.freedesktop.org";
          owner = "upower";
          repo = "power-profiles-daemon";
          rev = "f8bea7c205afc4b3101edc31b8e9b35780b0ceb6";
          sha256 = "sha256-+TAZNZOChG4FASdGpBL3mQsFZgUhLrmWFpbxHjTyWgE=";
        };
      }
    );
  };

  services.fwupd = # Bios updates
  {
    enable = true;
    extraRemotes = [ "lvfs-testing" ];
  };

  boot.kernelParams = # Supposedly better battery
  [
    "amd_pstate=active"
  ];

  powerManagement.powertop.enable = true; # Auto tune power

  hardware.wirelessRegulatoryDatabase = true; # Speed up wifi?
  boot.extraModprobeConfig =
  ''
    options cfg80211 ieee80211_regdom="US"
  '';
}