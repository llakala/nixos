{ fetchFromForgejo, vimUtils }:

vimUtils.buildVimPlugin {
  name = "canola-nvim";
  # fails 'require' check because of need for git executable
  doCheck = false;

  src = fetchFromForgejo {
    domain = "forge.barrettruth.com";
    owner = "barrettruth";
    repo = "canola.nvim";
    rev = "176da3fcc08b7c054b1746c7a5631aaf058906bf";
    hash = "sha256-ONckumAkFtssunafmvlTonEzcRfEWWsC8n9t/nw384c=";
  };
}
