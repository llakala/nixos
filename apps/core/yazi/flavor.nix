{ inputs, ... }:

{

  programs.yazi =
  {
    settings.theme =
    {
      flavor.use = "kanagawa";
    };
    flavors =
    {
      kanagawa = inputs.kanagawa-yazi;
    };
  };
}
