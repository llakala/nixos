{ ... }:

{


  boot.kernelModules = [ "kvm-amd" ];

  virtualisation =
  {
    vmVariant.virtualisation =
    {
      memorySize = 2048; # 2 gigs
      cores = 3;
      diskSize = 4096; # 4 gigs
    };
  };


}