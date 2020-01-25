" indentation stuff
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

" highlight characters exceeding the 110 limit
set colorcolumn=120
highlight ColorColumn ctermbg=darkgray
set colorcolumn=110
highlight ColorColumn ctermbg=darkgray

" generate tags on save
autocmd BufWritePost * :GenerateCtags
