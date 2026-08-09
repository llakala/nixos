{ vimPlugins, fetchFromGitHub }:

# Pointing to my fork that makes a line with only spaces count as indented
vimPlugins.mini-indentscope.overrideAttrs {
  src = fetchFromGitHub {
    owner = "llakala";
    repo = "mini.indentscope";
    rev = "32747c85a928337d6a569bd88ffa9d587eb52f49";
    hash = "sha256-QQUyz9OdHaQGx0vTS39kdQqTZ9YPxtx63jAXwJoJ6yc=";
  };
}
