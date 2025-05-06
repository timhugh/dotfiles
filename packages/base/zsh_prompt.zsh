function git_branch_name() {
    branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    if [[ -n $branch ]]; then
        echo "($branch) "
    fi
}

setopt prompt_subst
prompt='%F{green}%~%f $(git_branch_name)%F{red}%#%f '

