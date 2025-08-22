{ config, ... }:

{
  baseVars.fullName = "Eman Resu";
  baseVars.email = "elevenaka11@gmail.com";

  baseVars.username = "emanresu";
  baseVars.homeDirectory = "/home/emanresu";

  baseVars.editor =
    assert config.features.editor == "neovim";
    "nvim";
}
