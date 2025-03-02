{ config, ... }:
{

  hardware.nvidia =
  {
    modesetting.enable = true;

    powerManagement.enable = false;

    powerManagement.finegrained = false;

    open = false;
    nvidiaSettings = true;

package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "570.124.04";
      sha256_64bit = "sha256-G3hqS3Ei18QhbFiuQAdoik93jBlsFI2RkWOBXuENU8Q=";
      sha256_aarch64 = "sha256-KCGUyu/XtmgcBqJ8NLw/iXlaqB9/exg51KFx0Ta5ip0=";
      openSha256 = "sha256-KCGUyu/XtmgcBqJ8NLw/iXlaqB9/exg51KFx0Ta5ip0=";
      settingsSha256 = "sha256-LNL0J/sYHD8vagkV1w8tb52gMtzj/F0QmJTV1cMaso8=";
      persistencedSha256 = "sha256-xctt4TPRlOJ685S52h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
    };
  };

  services.xserver.videoDrivers = ["nvidia"]; # Use proprietary drivers
}
