function! DarkModeEnabled()
  return system('dark-mode-enabled') =~ 'true'
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
endfunction

function! ToggleDarkMode()
  silent execute '!toggle-dark-mode'
  call SetTheme()
endfunction

" set theme on startup
call SetTheme()
