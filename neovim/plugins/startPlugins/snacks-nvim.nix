{ vimPlugins, fetchFromGitHub }:

# Pointing to my fork that fixes a performance issue
# See https://github.com/folke/snacks.nvim/pull/2805
vimPlugins.snacks-nvim.overrideAttrs {
  src = fetchFromGitHub {
    owner = "llakala";
    repo = "snacks.nvim";
    rev = "81224281ac37f23bb8569e4fa941712fa9d7aae3";
    hash = "sha256-6zwoUH7G/l/CueGEPL0wmWrOZMQKlOfiVl+JMpMfDW0=";
  };
}
