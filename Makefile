DOT_ROOT := $(shell pwd)
NODE_VERSION ?= 15.2.1
RUBY_VERSION ?= 2.7.2

install: build-essential oh-my-zsh misc-dotfiles bin vim node ruby

.PHONY: oh-my-zsh
oh-my-zsh: zsh ${HOME}/.oh-my-zsh zshrc chsh
${HOME}/.oh-my-zsh: curl zsh
	test -d $@ || (cd ${HOME}; curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash)

zsh: apt-update
	command -v $@ || sudo apt install -y $@

.PHONY: zshrc
zshrc: ${HOME}/.zshrc ${HOME}/.zsh_aliases ${HOME}/.zsh_profile.d
# zshrc is phony b/c it needs to overwrite the one oh-my-zsh creates
.PHONY: ${HOME}/.zshrc
${HOME}/.zshrc: ${DOT_ROOT}/zsh/zshrc
	rm $@ && ln -s $< $@
${HOME}/.zsh_aliases: ${DOT_ROOT}/zsh/zsh_aliases
	ln -s $< $@
${HOME}/.zsh_profile.d: ${DOT_ROOT}/zsh/zsh_profile.d
	ln -s $< $@

chsh:
	chsh -s $(shell which zsh)

.PHONY: vim
vim: neovim vimrc vim-plugins

.PHONY: neovim
neovim: ${HOME}/src/neovim cmake pkg-config automake libtool libtool-bin unzip gettext
	command -v nvim || (cd ${HOME}/src/neovim && make && sudo make install)

${HOME}/src/neovim: git
	mkdir -p ${HOME}/src
	test -d $@ || git clone --depth 1 --branch stable https://github.com/neovim/neovim.git $@

.PHONY: vimrc
vimrc: ${HOME}/.vimrc ${HOME}/.config/nvim ${HOME}/.vim
${HOME}/.vimrc: ${DOT_ROOT}/vim/vimrc
	ln -s $< $@
${HOME}/.config/nvim: ${DOT_ROOT}/vim/nvim
	mkdir -p ${HOME}/.config
	ln -s $< $@
${HOME}/.vim: ${DOT_ROOT}/vim
	ln -s $< $@

.PHONY: vim-plugins
vim-plugins: vundle fzf silversearcher-ag
	nvim +PluginClean +PluginInstall +qall

.PHONY: vundle
vundle: ${DOT_ROOT}/vim/bundle/Vundle.vim
${DOT_ROOT}/vim/bundle/Vundle.vim: git
	test -d $@ || ( \
		mkdir -p ${DOT_ROOT}/vim/bundle; \
		git clone https://github.com/VundleVim/Vundle.vim.git ${DOT_ROOT}/vim/bundle/Vundle.vim \
	)

.PHONY: node
node: nodenv node-build
	test -d ${HOME}/.nodenv/versions/${NODE_VERSION} || \
		${HOME}/.nodenv/bin/nodenv install ${NODE_VERSION}
	${HOME}/.nodenv/bin/nodenv global ${NODE_VERSION}

.PHONY: nodenv
nodenv: ${HOME}/.nodenv
${HOME}/.nodenv: git
	test -d $@ || git clone https://github.com/nodenv/nodenv.git $@

.PHONY: node-build
node-build: ${HOME}/.nodenv/plugins/node-build

${HOME}/.nodenv/plugins/node-build: git
	mkdir -p ${HOME}/.nodenv/plugins
	test -d $@ || git clone https://github.com/nodenv/node-build.git $@

.PHONY: ruby
ruby: chruby ruby-install ${HOME}/.ruby-version
	test -d ${HOME}/.rubies/ruby-${RUBY_VERSION} || \
		ruby-install ruby ${RUBY_VERSION}
chruby: wget
	mkdir ${HOME}/src; cd ${HOME}/src; \
		wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz && \
		tar -xzvf chruby-0.3.9.tar.gz && \
		cd chruby-0.3.9/; \
		sudo make install
ruby-install: wget
	mkdir ${HOME}/src; cd ${HOME}/src; \
		wget -O ruby-install-0.7.1.tar.gz https://github.com/postmodern/ruby-install/archive/v0.7.1.tar.gz && \
		tar -xzvf ruby-install-0.7.1.tar.gz && \
		cd ruby-install-0.7.1/; \
		sudo make install
${HOME}/.ruby-version:
	echo ruby-${RUBY_VERSION} > $@

.PHONY: bin
bin: ${HOME}/bin
# TODO get this to just link the files instead of the whole directory
${HOME}/bin: ${DOT_ROOT}/bin
	ln -s $< $@
	# for f in $<; do echo 'linking $f'; ln -s $f ${HOME}/bin/; done

.PHONY: misc-dotfiles
misc-dotfiles: ${HOME}/.ctags ${HOME}/.gitignore ${HOME}/.gitconfig ${HOME}/.irbrc ${HOME}/.tmux.conf
${HOME}/.ctags: ${DOT_ROOT}/misc/ctags
	ln -s $< $@
${HOME}/.gitignore: ${DOT_ROOT}/misc/gitignore
	ln -s $< $@
${HOME}/.gitconfig: ${DOT_ROOT}/misc/gitconfig
	ln -s $< $@
${HOME}/.irbrc: ${DOT_ROOT}/misc/irbrc
	ln -s $< $@
${HOME}/.tmux.conf: ${DOT_ROOT}/misc/tmux.conf
	ln -s $< $@

.PHONY: git
git: apt-update
	command -v $@ || sudo apt install -y $@
.PHONY: curl
curl: apt-update
	command -v $@ || sudo apt install -y $@
.PHONY: wget
wget: apt-update
	command -v $@ || sudo apt install -y $@
.PHONY: fzf
fzf: apt-update
	command -v $@ || sudo apt install -y $@
.PHONY: silversearcher-ag
silversearcher-ag: apt-update
	command -v $@ || sudo apt install -y $@
.PHONY: cmake
cmake: apt-update
	command -v $@ || sudo apt install -y $@
.PHONY: pkg-config
pkg-config: apt-update
	command -v $@ || sudo apt install -y $@
.PHONY: libtool
libtool: apt-update
	command -v $@ || sudo apt install -y $@
.PHONY: libtool-bin
libtool-bin: apt-update
	command -v $@ || sudo apt install -y $@
.PHONY: automake
automake: apt-update
	command -v $@ || sudo apt install -y $@
.PHONY: unzip
unzip: apt-update
	command -v $@ || sudo apt install -y $@
.PHONY: gettext
gettext: apt-update
	command -v $@ || sudo apt install -y $@
.PHONY: build-essential
	command -v $@ || sudo apt install -y $@

.PHONY: apt-update
apt-update:
	sudo apt update
