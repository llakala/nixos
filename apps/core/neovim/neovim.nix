{ lib, pkgs, pkgs-unstable, ... }:

{

  environment.variables.EDITOR = "nvim";
  hm.programs.neovim =
  {
    enable = true;
    package = pkgs-unstable.neovim-unwrapped;
    extraLuaConfig = lib.mkBefore (lib.fileContents ./init.lua);
  };

  hm.programs.neovim.plugins =
  [
    {
      plugin = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
      type = "lua";
      config =
      ''
        require'nvim-treesitter.configs'.setup{
          highlight =
          {
            enable = true,
          },
        }
    '';
    }
  ];
}
