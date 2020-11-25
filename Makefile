DOT_ROOT := $(shell git rev-parse --show-toplevel)
NODE_VERSION ?= 15.2.1
RUBY_VERSION ?= 2.7.2
GO_VERSION ?= 1.15.5

install: build-essential node ruby golang misc-dotfiles bin vim oh-my-zsh

include install/_common.mk

.PHONY: node
node:
	$(MAKE) --file ${DOT_ROOT}/install/$@.mk

.PHONY: ruby
ruby:
	$(MAKE) --file ${DOT_ROOT}/install/$@.mk

.PHONY: oh-my-zsh
oh-my-zsh:
	$(MAKE) --file ${DOT_ROOT}/install/$@.mk

.PHONY: vim
vim: neovim vimrc vim-plugins coc-extensions

.PHONY: neovim
neovim: ${HOME}/src/neovim cmake pkg-config automake libtool libtool-bin unzip gettext
	command -v nvim || (cd ${HOME}/src/neovim && $(MAKE) && sudo $(MAKE) install)

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

.PHONY: coc-extensions
coc-extensions: clangd
	mkdir -p ${HOME}/.config/coc/extensions
	npm --prefix ${HOME}/.config/coc/extensions install coc-clangd coc-css coc-html coc-tsserver coc-json coc-solargraph coc-go \
		--global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod

.PHONY: vundle
vundle: ${DOT_ROOT}/vim/bundle/Vundle.vim
${DOT_ROOT}/vim/bundle/Vundle.vim: git
	test -d $@ || ( \
		mkdir -p ${DOT_ROOT}/vim/bundle; \
		git clone https://github.com/VundleVim/Vundle.vim.git ${DOT_ROOT}/vim/bundle/Vundle.vim \
	)

.PHONY: golang
golang: /usr/local/go
/usr/local/go: ${HOME}/src/go${GO_VERSION}.linux-amd64.tar.gz
	sudo tar -C /usr/local -xzvf $<
${HOME}/src/go${GO_VERSION}.linux-amd64.tar.gz:
	wget -O $@ https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz

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
