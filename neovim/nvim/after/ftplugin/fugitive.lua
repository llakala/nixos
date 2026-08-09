vim.cmd([[
  resize 12

  " Remove the default d binds, so we can map `d` to inline diff
  nunmap <buffer> dp
  nunmap <buffer> dd
  nunmap <buffer> dv
  nunmap <buffer> ds
  nunmap <buffer> dh
  nunmap <buffer> dq
  nunmap <buffer> d?
]])

-- d for diff
vim.keymap.set("n", "d", "<plug>fugitive:=", { buffer = true })
