set nocompatible
syntax on
set encoding=utf8
colorscheme delek
set noerrorbells novisualbell

let mapleader=","
inoremap jj <esc>


""" START VUNDLE CONFIG
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle manages itself
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-vinegar'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'tpope/vim-surround'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-endwise'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'vim-scripts/StripWhiteSpaces'

" enhanced selectors
Plugin 'tmhedberg/matchit'
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'lucapette/vim-textobj-underscore'

" git stuff
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
Plugin 'tommcdo/vim-fubitive'
Plugin 'airblade/vim-gitgutter'

" writing stuff
Plugin 'junegunn/goyo.vim'
Plugin 'junegunn/limelight.vim'

" tag browsing / searching
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'gasparch/ctrlp-tagbar.vim'

" ruby
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rake'
Plugin 'ecomba/vim-ruby-refactoring'
Plugin 'ngmy/vim-rubocop'
Plugin 'rainerborene/vim-reek'
Plugin 'tpope/vim-bundler'

" rails
Plugin 'tpope/vim-rails'
Plugin 'thoughtbot/vim-rspec'

" go
Plugin 'fatih/vim-go'

" crystal
Plugin 'rhysd/vim-crystal'

" javascript
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

" confluence
Plugin 'vim-scripts/confluencewiki.vim'

call vundle#end()
filetype plugin indent on
""" END VUNDLE CONFIG


""" START PLUGIN CONFIG

" goyo / limelight config
nnoremap <leader>G :Goyo<CR>
let g:goyo_width = 120
let g:limelight_conceal_ctermfg = 'gray'
function! s:goyo_enter()
  set wrap linebreak
  Limelight
endfunction
function! s:goyo_leave()
  set nowrap nolinebreak
  Limelight!
endfunction
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" tagbar config
nnoremap <leader>R :TagbarOpenAutoClose<CR>

" vim-jsx config
let g:jsx_ext_required = 0

" ctrlp.vim config
let g:ctrlp_map = '<leader>t'
let g:ctrlp_show_hidden=1
let g:ctrlp_switch_buffer=0
nnoremap <leader>r :CtrlPBufTag<CR>
let g:ctrlp_buftag_types = {
\   'go' : '--language-force=go --go-types=d'
\ }
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

" StripWhiteSpaces config
let g:strip_trailing_lines = 1

" vim-fugitive config
nnoremap <leader>gl :Glog<CR>:copen<CR>

""" END PLUGIN CONFIG


" fzf
if executable('fzf')
  set rtp+=/usr/local/opt/fzf
endif

" silent wrapper
" (courtesy of https://vi.stackexchange.com/a/1958)
:command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'

" toggle word wrap
set nowrap
nnoremap <leader>W :set wrap!<CR>

" open tab and set local working directory in first window
" (effectively, this should mean that every window opened in that tab will use
" the local working directory)
command! -nargs=1 -complete=file Tab silent! :tabe <args> | :lcd <args>
nnoremap <leader>E :Tab<SPACE>

" auto display line numbers in active buffer
set relativenumber

" ctags
command Ctags call Ctags()
function Ctags()
  if executable('ctags')
    execute 'Silent ctags -R > /dev/null &'
  endif
endfunction

" indentation stuff
set tabstop=2
set shiftwidth=2
set expandtab autoindent smartindent

" more natural backspace behaviour
set backspace=indent,eol,start

" set swap file directory to keep git working directories clean
set directory=$HOME/.vim/swapfiles//

" default to system clipboard
" set clipboard=unnamed

" search settings
set hlsearch incsearch ignorecase
nmap <silent> <leader>/ :nohlsearch<CR>

" Use ag for search
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  nnoremap \ :Ag<SPACE>
endif

" search cwd for highlighted word
nnoremap <leader>* :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" join lines with comma delimiter
nnoremap <leader>J :s/\n/, /<CR>

" more natural window splitting
set splitbelow
set splitright
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

" .vimrc editing shortcuts
noremap <leader>ev :tabnew $MYVIMRC<CR>
noremap <leader>sv :source $MYVIMRC<CR>
" autocmd BufWritePost .vimrc source %
