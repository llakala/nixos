if !exists('g:fugitive_browse_handlers')
    let g:fugitive_browse_handlers = []
endif

" Custom codeberg handler for GBrowse - feel free to steal.
function! CodebergHandler(opts)
  if a:opts.remote !~? 'codeberg.org'
      return
  endif

  if a:opts.type != 'blob'
      return
  endif

  " From https://www.reddit.com/r/vim/comments/slkfy0/adding_custom_handlers_for_gbrowse_command/
  let remote = substitute(a:opts.remote, '^.*//', '', '')
  let remote = substitute(remote, 'git@', '', '')
  let remote = substitute(remote, ':', '\/', '')
  let remote = substitute(remote, '\.git$', '', '')

  if a:opts.line1 == 0
    return "https://" . remote . "/src/branch/" . a:opts.commit . "/" . a:opts.path
  elseif a:opts.line1 == a:opts.line2
    return "https://" . remote . "/src/commit/" . a:opts.commit . "/" . a:opts.path . "#L" . a:opts.line1
  else
    return "https://" . remote . "/src/commit/" . a:opts.commit . "/" . a:opts.path . "#L" . a:opts.line1 . "-L" . a:opts.line2
  endif
endfunction

let s:handlers = get(g:, 'fugitive_browse_handlers', [])
let g:fugitive_browse_handlers = add(s:handlers, function('CodebergHandler'))
