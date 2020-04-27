# Utility functions for managing dark/light mode theming OS-wide
#
# * Control OS X dark mode
# * Control the profile in the current iTerm session
# * Automatically set the correct profile in new iTerm sessions
#
# Applescript borrowed from https://brettterpstra.com/2018/09/26/shell-tricks-toggling-dark-mode-from-terminal/
# Setting iTerm profile borrowed from https://coderwall.com/p/s-2_nw/change-iterm2-color-profile-from-the-cli

function set-iterm-dark-mode {
  newState=$1
  if [ -z "$newState" ] || [ "$newState" != 'true' ] && [ "$newState" != 'false' ];
  then
    echo "Usage: set-iterm-dark-mode [true|false]"
    return 1
  fi

  if [ "$newState" = 'true' ];
  then
    newProfile='dark'
  else
    newProfile='light'
  fi

  printf "\033]50;SetProfile=$newProfile\a"
}

function os-dark-mode-enabled {
  echo $(osascript -e 'tell app "System Events" to tell appearance preferences to return dark mode')
}

function set-os-dark-mode {
  newState=$1
  if [ -z "$newState" ] || [ "$newState" != 'true' ] && [ "$newState" != 'false' ];
  then
    echo "Usage: set-os-dark-mode [true|false]"
    return 1
  fi

  osascript -e "tell app \"System Events\" to tell appearance preferences to set dark mode to $newState"
}

function set-global-dark-mode {
  newState=$1
  if [ -z "$newState" ] || [ "$newState" != 'true' ] && [ "$newState" != 'false' ];
  then
    echo "Usage: set-global-dark-mode [true|false]"
    return 1
  fi

  set-os-dark-mode $newState
  set-iterm-dark-mode $newState
}

function toggle-global-dark-mode {
  if [ $(os-dark-mode-enabled) = 'true' ];
  then
    set-global-dark-mode 'false'
  else
    set-global-dark-mode 'true'
  fi
}

function sync-iterm-dark-mode-with-os {
  set-iterm-dark-mode `os-dark-mode-enabled`
}
