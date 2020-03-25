" autogenerate tags on save
autocmd BufWritePost * :GenerateCtags

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

" vim-rspec config
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

let g:rspec_command = "Dispatch bundle exec spring rspec {spec}"
