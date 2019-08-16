" vim-go config
nnoremap <leader>T :GoTest<CR>
nnoremap <leader>B :GoBuild<CR>
nnoremap ^] :GoDef<CR>

set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

let g:go_fmt_command = "goimports"
