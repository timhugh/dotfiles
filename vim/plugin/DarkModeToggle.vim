let g:dark_mode_enabled = 'true'

function! DarkModeEnabled()
  return g:dark_mode_enabled =~ 'true'
"   return system('dark-mode-enabled') =~ 'true'
endfunction

function! SetTheme()
  if DarkModeEnabled()
    colorscheme brogrammer
    set background=dark
    let g:airline_theme = 'badwolf'
  else
    colorscheme summerfruit256
    set background=light
    let g:airline_theme = 'light'
  endif

  " refresh airline if it has already been loaded
  if exists(':AirlineRefresh')
    AirlineRefresh
  endif
endfunction

function! ToggleDarkMode()
  " silent execute '!toggle-dark-mode'
  if DarkModeEnabled()
    let g:dark_mode_enabled = 'false'
  else
    let g:dark_mode_enabled = 'true'
  endif
  call SetTheme()
endfunction

noremap <leader>D :call ToggleDarkMode()<CR>

" set theme on startup
call SetTheme()
