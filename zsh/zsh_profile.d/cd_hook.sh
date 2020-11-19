# override `cd` to run hooks in current directory (if applicable)
function cd {
  builtin cd "$@" || return
  [[ -f ./.cd_hook ]] && . ./.cd_hook || return
}
[[ -f ./.cd_hook ]] && . ./.cd_hook
