{ ... }:

{
  hm.programs.helix =
  {
    enable = true;
    defaultEditor = false; # We do this manually via the EDITOR variable
  };

  hm.programs.helix.settings =
  {
    keys.normal = # We will learn hjkl 
    {
      up = "no_op";
      down = "no_op";
      left = "no_op";
      right = "no_op";
    };
  };
}