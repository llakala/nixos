" Modified version of typst.vim indentexpr, adding some hacky logic to indent
" inside a math block. Abuses treesitter - here be dragons!
"
" typst.vim indentexpr sourced ethically from:
" https://github.com/kaarmu/typst.vim/blob/1d5436c0f55490893892441c0eca55e6cdf4916c/indent/typst.vim#L12
let s:cpo_save = &cpoptions
set cpoptions&vim

setlocal autoindent
setlocal indentexpr=TypstIndentExpr()
function! TypstIndentExpr() abort
    return TypstIndent(v:lnum)
endfunction

function! TypstIndent(lnum) abort
    let s:sw = shiftwidth()

    let [l:plnum, l:pline] = s:get_prev_nonblank(a:lnum - 1)
    if l:plnum == 0 | return 0 | endif

    let l:line = getline(a:lnum)
    let l:ind = indent(l:plnum)

    let l:synname = synIDattr(synID(a:lnum, 1, 1), "name")

    if l:synname == 'typstCommentBlock'
        return l:ind
    elseif l:synname == 'typstMarkupBulletList'
        return indent(a:lnum)
    endif

    if l:pline =~ '\v[{[(]\s*$'
        let l:ind += s:sw
    endif

    if l:line =~ '\v^\s*[}\])]'
        let l:ind -= s:sw
    endif

    " Custom logic to indent over inside a math block. Using treesitter is gross
    " here, but I couldn't find a nicer way to detect whether I'm in a $ block..
    if l:pline =~ '^\s*\$$' && ! (l:line =~ '^\s*\$$') && v:lua.Custom.in_ts_group([ 'math' ], [])
        let l:ind += s:sw
    endif

    return l:ind
endfunction

function! s:get_prev_nonblank(lnum) abort
    let l:lnum = prevnonblank(a:lnum)
    let l:line = getline(l:lnum)

    while l:lnum > 0 && l:line =~ '^\s*//'
        let l:lnum = prevnonblank(l:lnum - 1)
        let l:line = getline(l:lnum)
    endwhile

    return [l:lnum, s:remove_comments(l:line)]
endfunction

function! s:remove_comments(line) abort
    return substitute(a:line, '\s*//.*', '', '')
endfunction

let &cpoptions = s:cpo_save
unlet s:cpo_save
