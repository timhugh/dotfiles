# Super manual process at the moment since the installer is really tied into homebrew and mac paths, but:

# need to use zsh for most of the install scripts. I should probably change that in the future:
sudo apt-get install zsh
chsh -s /usr/bin/zsh

# link all of the symlink and .zsh files manually e.g.:
ln -s ${HOME}/share/dotfiles/packages/base/zshrc.symlink ~/.zshrc
mkdir -p ~/.zsh_profile.d
ln -s ${HOME}/share/dotfiles/packages/base/git.zsh ~/.zsh_profile.d/

# installers are (mostly) runnable
cd packages/ruby
source ruby.install

# there are some manual installs, though!

# neovim - the version in apt is just way too old
mkdir -p ~/tmp
cd ~/tmp
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz

# chruby and ruby-install
mkdir -p ~/tmp
cd ~/tmp
wget https://github.com/postmodern/chruby/releases/download/v0.3.9/chruby-0.3.9.tar.gz
tar -xzvf chruby-0.3.9.tar.gz
cd chruby-0.3.9/
sudo make install
wget https://github.com/postmodern/ruby-install/releases/download/v0.9.3/ruby-install-0.9.3.tar.gz
tar -xzvf ruby-install-0.9.3.tar.gz
cd ruby-install-0.9.3/
sudo make install

# nodenv
git clone https://github.com/nodenv/nodenv.git ~/.nodenv
git clone https://github.com/nodenv/node-build.git ~/.nodenv/plugins/node-build

# golangci-lint -- just doesn't exist in apt
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b "${GOPATH}"/bin v1.59.1

