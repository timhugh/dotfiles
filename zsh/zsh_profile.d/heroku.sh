# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/tim/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

alias stg-run="heroku run --remote stage"
alias prod-run="heroku run --remote prod"
alias stg-logs="heroku logs --remote stage --tail"
alias prod-logs="heroku logs --remote prod --tail"

