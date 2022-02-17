DOT_ROOT ?= $(shell git rev-parse --show-toplevel)

.PHONY: bin
bin: with_env snow

.PHONY: with_env
with_env: ${HOME}/bin ${HOME}/bin/with_env
${HOME}/bin/with_env: ${DOT_ROOT}/bin/with_env
	ln -s $< $@

.PHONY: snow
snow: ${HOME}/bin ${HOME}/bin/snow
${HOME}/bin/snow: ${DOT_ROOT}/bin/snow
	ln -s $< $@

${HOME}/bin:
	mkdir -p $@
