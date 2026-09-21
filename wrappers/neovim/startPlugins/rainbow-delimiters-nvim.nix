{ vimPlugins, fetchFromGitHub }:

# See https://github.com/HiPhish/rainbow-delimiters.nvim/pull/219
vimPlugins.rainbow-delimiters-nvim.overrideAttrs {
  src = fetchFromGitHub {
    owner = "HiPhish";
    repo = "rainbow-delimiters.nvim";
    rev = "74b05d28bdf5804d185affb0c72aafe27c318032";
    hash = "sha256-cai84Wpv/6QvqVZrb+lYRhE0L5ZWgR0933gqsOHMSUw=";
  };
}
