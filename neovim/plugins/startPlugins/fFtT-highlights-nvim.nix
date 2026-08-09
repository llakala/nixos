{ fetchFromGitHub }:

# THis isn't an actual plugin derivation, but it's being interpreted as one by
# mnw, which will just reuse `src.outPath` for the plugin definition. Means we
# don't have to include the src in our closure twice. Horrible - I love it.
{
  name = "fFtT-highlights-nvim";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "samiulsami";
    repo = "fFtT-highlights.nvim";
    rev = "4ce97e9748686825f8a9d6a3b80f76c9fd0a55ee";
    hash = "sha256-zTd+BnLaYPBP6hBaJbfYGW38sT68/JgHHQSzg9ORvPg=";
  };
}
