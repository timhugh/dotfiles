DOT_ROOT ?= $(shell git rev-parse --show-toplevel)
NODE_VERSION ?= 16.14.2

.PHONY: node
node: nodenv node-build
	test -d ${HOME}/.nodenv/versions/${NODE_VERSION} || \
		${HOME}/.nodenv/bin/nodenv install ${NODE_VERSION}
	${HOME}/.nodenv/bin/nodenv global ${NODE_VERSION}

include ${DOT_ROOT}/install/_common.mk

.PHONY: nodenv
nodenv: ${HOME}/.nodenv
${HOME}/.nodenv: git
	test -d $@ || git clone https://github.com/nodenv/nodenv.git $@

.PHONY: node-build
node-build: ${HOME}/.nodenv/plugins/node-build

${HOME}/.nodenv/plugins/node-build: git
	mkdir -p ${HOME}/.nodenv/plugins
	test -d $@ || git clone https://github.com/nodenv/node-build.git $@
