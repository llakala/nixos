{


  disko.devices.disk.my-disk =
  {
    device = "/dev/sdb";
    type = "disk";
    content.type = "gpt";
    content.partitions =
    {
      ESP =
      {
        type = "EF00";
        size = "500M";
        content =
        {
          type = "filesystem";
          format = "vfat";
          mountpoint = "/boot";
        };
      };


      root =
      {
        size = "100%";
        content =
        {
          type = "filesystem";
          format = "ext4";
          mountpoint = "/";
        };
      };
    };
  };



}