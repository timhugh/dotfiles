# add user bin and brew to path
export PATH=$HOME/bin:/usr/local/bin:$PATH

# oh-my-zsh directory and config
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(brew git chruby ruby bundler rails npm heroku zsh-interactive-cd osx docker docker-compose)
source $ZSH/oh-my-zsh.sh

# load config directory
for f in $HOME/.zsh_profile.d/*.sh; do
  source $f
done

source $HOME/.zsh_aliases

# and display a nice banner
header
