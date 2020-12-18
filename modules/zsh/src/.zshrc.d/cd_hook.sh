# override `cd` to run hooks in current directory (if applicable)
function cd {
  builtin cd "$@" || return 1
  [[ -f ./.cd_hook ]] && . ./.cd_hook || return 0
}
[[ -f ./.cd_hook ]] && . ./.cd_hook
