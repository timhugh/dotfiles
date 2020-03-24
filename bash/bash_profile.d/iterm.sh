
alias light='change-iterm-theme light'
alias dark='change-iterm-theme dark'

function change-iterm-theme () {
  echo -e "\033]50;SetProfile=$1\a";
  export ITERM_PROFILE=$1;
}
