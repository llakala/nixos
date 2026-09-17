{ fetchFromGitHub, vimUtils }:

vimUtils.buildVimPlugin {
  name = "fFtT-highlights-nvim";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "samiulsami";
    repo = "fFtT-highlights.nvim";
    rev = "4ce97e9748686825f8a9d6a3b80f76c9fd0a55ee";
    hash = "sha256-zTd+BnLaYPBP6hBaJbfYGW38sT68/JgHHQSzg9ORvPg=";
  };
}
