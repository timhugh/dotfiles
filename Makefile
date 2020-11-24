DOT_ROOT := $(pwd)
NODE_VERSION = 15.2.1
RUBY_VERSION = 2.7.2

install: oh-my-zsh vim node ruby bin misc-dotfiles

.PHONY: oh-my-zsh
oh-my-zsh: zsh ~/.oh-my-zsh zshrc
~/.oh-my-zsh: curl zsh
	cd ~; \
	  curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash

zsh: apt-update
	sudo apt install -y zsh

.PHONY: zshrc
zshrc: ~/.zshrc ~/.zsh_aliases ~/.zsh_profile.d
~/.zshrc: ${DOT_ROOT}/zsh/zshrc
	ln -s $< $@
~/.zsh_aliases: ${DOT_ROOT}/zsh/zsh_aliases
	ln -s $< $@
~/.zsh_profile.d: ${DOT_ROOT}/zsh/zsh_profile.d
	ln -s $< $@

.PHONY: vim
vim: neovim vimrc vim-plugins

neovim: apt-update
	sudo apt install -y neovim

.PHONY: vimrc
vimrc: ~/.vimrc ~/.config/nvim ~/.vim
~/.vimrc: ${DOT_ROOT}/vim/vimrc
	ln -s $< $@
~/.config/nvim: ${DOT_ROOT}/vim/nvim
	ln -s $< $@
~/.vim: ${DOT_ROOT}/vim
	ln -s $< $@

.PHONY: vim-plugins
vim-plugins: vundle
	vim +PluginClean +PluginInstall +qall

.PHONY: vundle
vundle: ${DOT_ROOT}/vim/bundle/Vundle.vim
${DOT_ROOT}/vim/bundle/Vundle.vim: git
	mkdir ${DOT_ROOT}/vim/bundle/Vundle.vim
	git clone https://github.com/VundleVim/Vundle.vim.git ${DOT_ROOT}/vim/bundle/Vundle.vim

.PHONY: node
node: nodenv
	~/.nodenv/bin/nodenv install ${NODE_VERSION}
	~/.nodenv/bin/nodenv global ${NODE_VERSION}

.PHONY: nodenv
nodenv: ~/.nodenv
~/.nodenv: curl
	cd ~; \
	  curl -fsSL https://raw.githubusercontent.com/nodenv/nodenv-installer/master/bin/nodenv-installer | bash

.PHONY: ruby
ruby: chruby ruby-install ~/.ruby-version
	ruby-install ruby ${RUBY_VERSION}
chruby:
	mkdir ~/src; cd ~/src; \
		wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz; \
		tar -xzvf chruby-0.3.9.tar.gz; \
		cd chruby-0.3.9/; \
		sudo make install
ruby-install:
	mkdir ~/src; cd ~/src; \
		wget -O ruby-install-0.7.1.tar.gz https://github.com/postmodern/ruby-install/archive/v0.7.1.tar.gz; \
		tar -xzvf ruby-install-0.7.1.tar.gz; \
		cd ruby-install-0.7.1/; \
		sudo make install
~/.ruby-version:
	echo ruby-${RUBY_VERSION} > $@

.PHONY: bin
bin: ~/bin
~/bin: ${DOT_ROOT}/bin
	for f in $<; do echo 'linking $f'; ln -s $f ~/bin/; done

.PHONY: misc-dotfiles
misc-dotfiles: ~/.ctags ~/.gitignore ~/gitconfig ~/.irbrc ~/.tmux.conf
~/.ctags: ${DOT_ROOT}/misc/ctags
	ln -s $< $@
~/.gitignore: ${DOT_ROOT}/misc/gitignore
	ln -s $< $@
~/.gitconfig: ${DOT_ROOT}/misc/gitconfig
	ln -s $< $@
~/.irbrc: ${DOT_ROOT}/misc/irbrc
	ln -s $< $@
~/.tmux.conf: ${DOT_ROOT}/misc/tmux.conf
	ln -s $< $@

curl: apt-update
	sudo apt install -y curl

apt-update:
	sudo apt update
