DOT_ROOT ?= $(shell git rev-parse --show-toplevel)

.PHONY: vim
vim: neovim vimrc vim-plugins coc-extensions

include ${DOT_ROOT}/install/_common.mk

.PHONY: neovim
neovim: ${DOT_ROOT}/tmp/neovim cmake pkg-config automake libtool libtool-bin unzip gettext
	command -v nvim || ( \
		$(MAKE) -C ${DOT_ROOT}/tmp/neovim && \
		sudo $(MAKE) -C ${DOT_ROOT}/tmp/neovim install \
	)

${DOT_ROOT}/tmp/neovim: git
	mkdir -p ${DOT_ROOT}/tmp
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

.PHONY: coc-extensions
coc-extensions: clangd
	mkdir -p ${HOME}/.config/coc/extensions
	npm --prefix ${HOME}/.config/coc/extensions install coc-clangd coc-css coc-html coc-tsserver coc-json coc-solargraph coc-go \
		--global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
