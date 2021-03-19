DOT_ROOT := $(shell git rev-parse --show-toplevel)
NODE_VERSION ?= 15.2.1
RUBY_VERSION ?= 2.7.2
GO_VERSION ?= 1.16

install: wget build-essential node ruby golang misc-dotfiles git-config bin oh-my-zsh vim

include install/_common.mk

.PHONY: node
node:
	$(MAKE) --file ${DOT_ROOT}/install/$@.mk

.PHONY: ruby
ruby:
	$(MAKE) --file ${DOT_ROOT}/install/$@.mk

.PHONY: golang
golang:
	$(MAKE) --file ${DOT_ROOT}/install/$@.mk

.PHONY: java
java:
	$(MAKE) --file ${DOT_ROOT}/install/$@.mk

.PHONY: git-config
git-config:
	$(MAKE) --file ${DOT_ROOT}/install/$@.mk

.PHONY: vim
vim:
	$(MAKE) --file ${DOT_ROOT}/install/$@.mk

.PHONY: oh-my-zsh
oh-my-zsh:
	$(MAKE) --file ${DOT_ROOT}/install/$@.mk

.PHONY: bin
bin: ${HOME}/bin
# TODO get this to just link the files instead of the whole directory
${HOME}/bin: ${DOT_ROOT}/bin
	ln -s $< $@
	# for f in $<; do echo 'linking $f'; ln -s $f ${HOME}/bin/; done

.PHONY: misc-dotfiles
misc-dotfiles: ${HOME}/.ctags ${HOME}/.irbrc ${HOME}/.tmux.conf
${HOME}/.ctags: ${DOT_ROOT}/misc/ctags
	ln -s $< $@
${HOME}/.irbrc: ${DOT_ROOT}/misc/irbrc
	ln -s $< $@
${HOME}/.tmux.conf: ${DOT_ROOT}/misc/tmux.conf
	ln -s $< $@
