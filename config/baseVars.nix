{ config, ... }:

{
  baseVars.fullName = "Eman Resu";
  baseVars.email = "elevenaka11@gmail.com";

  baseVars.editor =
    assert config.features.editor == "neovim";
    "nvim";
}
