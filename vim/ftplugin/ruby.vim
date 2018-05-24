autocmd BufWritePost * :GenerateCtags

noremap <leader>nn o# NOTE: <esc>==A
noremap <leader>nt O# TODO: <esc>==A
noremap <leader>nf O# FIXME: <esc>==A

" use ripper-tags if it's available
if executable('ripper-tags')
  function! GenerateCtags()
    execute 'Silent ripper-tags -R > /dev/null &'
  endfunction
endif
