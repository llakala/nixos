{ ... }:

{



  boot.kernelModules = [ "kvm-amd" ];


  virtualisation = # NOT VIRTUALIZATION
  {
    libvirtd.enable = true;
    docker.enable = true;
  };


}