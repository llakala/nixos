{
  inputs,
  pkgs-stable,
  vars,
  ...
}:

{
  nixos =
  {
    modules =
    [
      ./nixos/os
      ./nixos/software
    ];
  };

  home =
  {
    modules =
    [
      ./home/os
      ./home/software
    ];

  };
}