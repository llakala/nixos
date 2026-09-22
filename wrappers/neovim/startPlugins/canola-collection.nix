{ fetchFromForgejo, vimUtils }:

vimUtils.buildVimPlugin {
  name = "canola-collection";
  # fails 'require' check because of need for git executable
  doCheck = false;

  src = fetchFromForgejo {
    domain = "forge.barrettruth.com";
    owner = "barrettruth";
    repo = "canola-collection";
    rev = "738a9e13d8cbf2aa348b5eced41c7ba0d0d9f9c6";
    hash = "sha256-nWNR0+GOB3CHskqy0JB9635DepeDOxYJcpJQA5hu5Fw=";
  };
}
