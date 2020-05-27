# handy git alias (now with autocomplete!)
alias g='git'
__git_complete g __git_main

# use hub in place of git
# (https://hub.github.com/)
[[ $(command -v hub) ]] && alias git='hub'
