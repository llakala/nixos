{ lib, pkgs, inputs, ... }:

let navigationBinds = type: 
{
  up = "no_op";
  down = "no_op";
  left = "no_op";
  right = "no_op";
  b = "no_op"; # We've moved the functionality of `b` to other keybinds


  # Select next word, plus extra space afterwards. Good for adding on via `w+a`
  w = "${type}_next_word_start";
  W = "${type}_prev_word_start";
  A-w = "${type}_next_long_word_start"; # alt-w
  A-W = "${type}_prev_long_word_start"; # alt-shift-w

  # Select next word, plus a space prior. Good for deletion via `e+d`
  e = "${type}_next_word_end";
  E = "${type}_prev_word_end";
  A-e = "${type}_next_long_word_end"; # alt-e
  A-E = "${type}_prev_long_word_end"; # alt-shift-e

  # Select next word, with no spaces selected at all. Great for replacing via `q+c`
  q = "@emiw"; # Uses macros, added in unstable helix version
  A-q = "@emiW"; 
   


  C-r = ":config-reload"; # Ctrl+r. Would ideally be :cr, but no way to make custom command aliases :(

  y = "yank_to_clipboard";
  p = "paste_clipboard_after";
  P = "paste_clipboard_before";
  R = "replace_selections_with_clipboard"; # Easier d+p

  d = "delete_selection_noyank";
  c = "change_selection_noyank"; # Easier d+i

  H = "goto_first_nonwhitespace";
  L = "goto_line_end";
};
in
{
  hm.programs.helix =
  {
    enable = true;
    package = inputs.helix-unstable.packages.${pkgs.system}.default; # Compile helix from source from commit adding macro support
    defaultEditor = true; # Sets EDITOR environment variable
    settings.theme = "onedarker";
  };

  hm.programs.helix.settings.editor =
  {
    indent-guides.render = true; # Show where indentations are with |

    mouse = false; # you'll thank me later

    cursor-shape =
    {
      insert = "bar";
      normal = "block";
      select = "underline";
    };
  };

  hm.programs.helix.settings.keys =
  {
    # Normal and select use the same custom binds, but normal moves the selection, while select extends the selection
    normal = navigationBinds "move";
    select = navigationBinds "extend";

    insert = # And we WILL only use normal mode for moving around
    {
      up = "no_op";
      down = "no_op";
      left = "no_op";
      right = "no_op";
    };

  };


  hm.programs.helix.languages.language =
  [
    {
      name = "nix";
      auto-format = false;
      language-servers = lib.singleton "nil";
    }
    {
      name = "python";
      auto-format = false;
      language-servers = lib.singleton "pylsp";
    }
    {
      name = "markdown";
      auto-format = false;
      language-servers = [ "mdpls" ];
    }

    {
      name = "json";
      auto-format = false;
      language-servers = lib.singleton "vscode-json-language-server";
    }
  ];

  hm.programs.helix.languages.language-server = # Define language server executables here so helix can access them
  {
    nil.command = lib.getExe pkgs.nil;

    pylsp.command = lib.getExe pkgs.python3Packages.python-lsp-server;

    mdpls.command = lib.getExe inputs.self.packages.${pkgs.system}.mdpls;

    vscode-json-language-server =
    {
      command = lib.getExe pkgs.nodePackages.vscode-json-languageserver;
      args = [ "--stdio" ];
      config.provideFormatter = false;
    };

  };
}
