DOT_ROOT ?= $(shell git rev-parse --show-toplevel)

git-config: gitconfig gitignore

include install/_common.mk

.PHONY: github-key
github-key: ${HOME}/.ssh/github_key
${HOME}/.ssh/github_key: openssh-client
	ssh-keygen -f $@ -q -N ''

.PHONY: gitignore
gitignore: ${HOME}/.gitignore
${HOME}/.gitignore: ${DOT_ROOT}/misc/gitignore
	ln -s $< $@

.PHONY: gitconfig
gitconfig: ${HOME}/.gitconfig
${HOME}/.gitconfig: ${DOT_ROOT}/misc/gitconfig
	ln -s $< $@

.PHONY: sshconfig
sshconfig: ${HOME}/.ssh/config
${HOME}/.ssh/config: ${DOT_ROOT}/misc/sshconfig
	mkdir -p ${HOME}/.ssh/config.d
	ln -s $< $@

