#################
# OS X DARK MODE
#################

# toggle dark mode
# (applescript stolen from https://brettterpstra.com/2018/09/26/shell-tricks-toggling-dark-mode-from-terminal/)
alias os-dark-mode="osascript -e 'tell app \"System Events\" to tell appearance preferences to return dark mode'"
function set-os-dark-mode {
  newState=$1
  if [ -z "$newState" ] || [ "$newState" != 'true' ] && [ "$newState" != 'false' ];
  then
    echo "Usage: set-os-dark-mode [true|false]"
    return 1
  fi

  osascript -e "tell app \"System Events\" to tell appearance preferences to set dark mode to $newState"
}

# change iterm profile
# (https://coderwall.com/p/s-2_nw/change-iterm2-color-profile-from-the-cli)
# sets the $ITERM_PROFILE env so other things can theme appropriately (mostly vim)
function iterm-dark-mode {
  return test $ITERM_PROFILE = 'dark'
}

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

  echo -e "\033]50;SetProfile=$newProfile\a"
  export ITERM_PROFILE=$newProfile
}

# sets the iterm profile to match OS dark mode
function sync-dark-mode {
  curState=`os-dark-mode`
  set-iterm-dark-mode $curState
}


# finally, functions for changing everything at once
function set-dark-mode {
  newState=$1
  if [ -z "$newState" ] || [ "$newState" != 'true' ] && [ "$newState" != 'false' ];
  then
    echo "Usage: set-dark-mode [true|false]"
    return 1
  fi

  set-os-dark-mode $newState
  set-iterm-dark-mode $newState
}
function toggle-dark-mode {
  curState=`os-dark-mode`
  if [ $curState == 'true' ]; then newState='false'; else newState='true'; fi

  set-dark-mode $newState
}
alias light='set-dark-mode false'
alias dark='set-dark-mode true'

# set iterm profile on new sessions
sync-dark-mode
