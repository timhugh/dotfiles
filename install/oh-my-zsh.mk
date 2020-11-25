DOT_ROOT ?= $(shell git rev-parse --show-toplevel)

.PHONY: oh-my-zsh
oh-my-zsh: zsh zshrc ${HOME}/.oh-my-zsh chsh

.PHONY: zsh
zsh:
	@command -v $@ || sudo apt install -y $@

${HOME}/.oh-my-zsh: ${DOT_ROOT}/tmp/oh-my-zsh-installer.sh
	CHSH=no RUNZSH=no KEEP_ZSHRC=yes sh $<

${DOT_ROOT}/tmp/oh-my-zsh-installer.sh:
	@mkdir -p ${DOT_ROOT}/tmp
	@wget -O $@ https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh

.PHONY: zshrc
zshrc: ${HOME}/.zshrc ${HOME}/.zsh_aliases ${HOME}/.zsh_profile.d
${HOME}/.zshrc: ${DOT_ROOT}/zsh/zshrc
	@ln -s $< $@
${HOME}/.zsh_aliases: ${DOT_ROOT}/zsh/zsh_aliases
	@ln -s $< $@
${HOME}/.zsh_profile.d: ${DOT_ROOT}/zsh/zsh_profile.d
	@ln -s $< $@

CURRENT_SHELL := $(shell awk -F: -v u="${USER}" 'u==$$1&&$$0=$$NF' /etc/passwd)
.PHONY: chsh
chsh:
	@test "${CURRENT_SHELL}" = $(shell which zsh) || chsh -s $(shell which zsh)
