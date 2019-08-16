" autogenerate tags on save
" autocmd BufWritePost * :GenerateCtags

" shortcuts for note comments
noremap <leader>nn o# NOTE: <esc>==A
noremap <leader>nt O# TODO: <esc>==A
noremap <leader>nf O# FIXME: <esc>==A

" use ripper-tags if it's available
if executable('ripper-tags')
  function! GenerateCtags()
    execute 'Silent ripper-tags -R > /dev/null &'
  endfunction
endif

" highlight characters exceeding the 120 limit
set colorcolumn=120
highlight ColorColumn ctermbg=darkgray

" indentation stuff
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab autoindent smartindent
