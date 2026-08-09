;; extends

((subject) @comment.error
  (#vim-match? @comment.error ".\{72,}")
  (#offset! @comment.error 0 72 0 0))

((message_line) @comment.error
  (#vim-match? @comment.error ".\{72,}")
  (#offset! @comment.error 0 72 0 0))
