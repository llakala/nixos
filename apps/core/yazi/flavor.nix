{ inputs, ... }:

{
  hm.programs.yazi = {
    theme = {
      flavor.use = "kanagawa";
    };
    flavors = {
      kanagawa = inputs.kanagawa-yazi;
    };
  };
}
