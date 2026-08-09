{ fetchFromGitHub }:

{
  name = "canola-collection";

  src = fetchFromGitHub {
    owner = "barrettruth";
    repo = "canola-collection";
    rev = "8566c09080c3084db1ffba21dec53e2b4235daed";
    hash = "sha256-NspywHVDp6c7Zw4b2M41OuULVlhGtGI0tj8LxP3x7SM=";
  };
}
