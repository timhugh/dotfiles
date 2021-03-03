# TODO: don't do this unless we're in WSL
/usr/bin/keychain --quiet --nogui $HOME/.ssh/github_key
source $HOME/.keychain/$(uname -n)-sh
