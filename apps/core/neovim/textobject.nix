{ pkgs, lib, ... }:

let
  vim-textobj-line = pkgs.vimUtils.buildVimPlugin
  {
    name = "vim-textobj-line";
    src = pkgs.fetchFromGitHub
    {
      owner = "kana";
      repo = "vim-textobj-line";
      rev = "0a78169a33c7ea7718b9fa0fad63c11c04727291";
      sha256 = "0mppgcmb83wpvn33vadk0wq6w6pg9cq37818d1alk6ka0fdj7ack";
    };
  };


in
{
  hm.programs.neovim =
  {
    plugins =
    [
      pkgs.vimPlugins.vim-textobj-user
      vim-textobj-line
    ];
    extraLuaConfig = lib.mkAfter
    /* lua */
    ''
      vmap("al", "<Plug>(textobj-line-a)")
      vmap("il", "<Plug>(textobj-line-i)")

      -- No clue why this isn't working in lua
      -- Makes x select the current line without newlines
      vim.cmd("nmap x val")

      -- When selecting, x to increase selection by a line, X to decrease it
      -- The textobj stuff means we don't have visual-line, so we emulate it, while
      -- not selecting ending newlines
      vnoremap("x", "jg_")
      vnoremap("X", "kg_")

      vnoremap("d", "$d")
    '';
  };
}
