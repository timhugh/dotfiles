if executable('rubocop')
  " autocmd BufWritePost * silent! :RuboCop %
  let g:vimrubocop_extra_args = '-D -P'
endif

autocmd BufWritePost * :Ctags
