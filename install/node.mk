DOT_ROOT ?= $(shell git rev-parse --show-toplevel)

.PHONY: node
node: nodenv node-build
	test -d ${HOME}/.nodenv/versions/${NODE_VERSION} || \
		${HOME}/.nodenv/bin/nodenv install ${NODE_VERSION}
	${HOME}/.nodenv/bin/nodenv global ${NODE_VERSION}

.PHONY: nodenv
nodenv: ${HOME}/.nodenv
${HOME}/.nodenv:
	test -d $@ || git clone https://github.com/nodenv/nodenv.git $@

.PHONY: node-build
node-build: ${HOME}/.nodenv/plugins/node-build

${HOME}/.nodenv/plugins/node-build:
	mkdir -p ${HOME}/.nodenv/plugins
	test -d $@ || git clone https://github.com/nodenv/node-build.git $@
