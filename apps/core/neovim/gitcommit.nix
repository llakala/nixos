{
  # Shows when the commit length goes too long
  # From https://github.com/gbprod/tree-sitter-gitcommit/pull/68
  hm.xdg.configFile."nvim/queries/gitcommit/highlights.scm" =
  {
    force = true;
    text =
    /* query */
    ''
      ;; extends

      ((subject) @comment.error
        (#vim-match? @comment.error ".\{50,}")
        (#offset! @comment.error 0 50 0 0))

      ((message_line) @comment.error
        (#vim-match? @comment.error ".\{72,}")
        (#offset! @comment.error 0 72 0 0))
    '';
  };
}
