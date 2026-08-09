{ fetchFromGitHub }:

{
  name = "canola-nvim";

  src = fetchFromGitHub {
    owner = "barrettruth";
    repo = "canola.nvim";
    rev = "d7c349fd0ffc3d6e8eceefdf66af66cb1ab42826";
    hash = "sha256-D2RAZiGasqVc4tMj9XU+M9o9oCoGF5zjV+w1eLvzeKQ=";
  };
}
