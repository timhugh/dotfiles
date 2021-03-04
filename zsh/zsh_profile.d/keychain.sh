# keychain handles ssh identities when an ssh agent is not present (e.g. WSL)
if [ -x "$(command -v keychain)" ]; then
  keychain --quiet --nogui $HOME/.ssh/github_key
  source $HOME/.keychain/$(uname -n)-sh
fi
