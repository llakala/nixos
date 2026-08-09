{ fetchFromGitHub }:
{
  name = "nvim-fundo";
  version = "unstable";
  src = fetchFromGitHub {
    owner = "kevinhwang91";
    repo = "nvim-fundo";
    rev = "c2b83cb19e4ac475f2b08aaf775afe3da19bc495";
    hash = "sha256-PGebG5bhwXYJ6cv1wSB/WOJZucoL6FGBiGdxkEtPl04=";
  };
}
