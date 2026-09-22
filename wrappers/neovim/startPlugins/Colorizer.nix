{ vimUtils, fetchFromGitHub }:

vimUtils.buildVimPlugin {
  name = "Colorizer";
  src = fetchFromGitHub {
    owner = "chrisbra";
    repo = "Colorizer";
    rev = "f5d69c0dea9f36e2eb025c7d86cc62b5a0d8af62";
    hash = "sha256-2dBFBr8enmMv681gpL8HJtl57kk7v6W9QXfw36teWDY=";
  };
}
