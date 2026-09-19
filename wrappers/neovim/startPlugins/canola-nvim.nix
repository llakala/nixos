{ fetchFromGitHub, vimUtils }:

vimUtils.buildVimPlugin {
  name = "canola-nvim";

  src = fetchFromGitHub {
    owner = "barrettruth";
    repo = "canola.nvim";
    rev = "3ca7adc52418cfadd0450fb0858413b9935f00d5";
    hash = "sha256-ZWavZPFXdJcloatFaNZraD5qz7XZvFLMlHDw1quq50I=";
  };
}
