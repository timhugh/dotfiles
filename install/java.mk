DOT_ROOT ?= $(shell git rev-parse --show-toplevel)
JENV_PATH = ${HOME}/.jenv

.PHONY: java
java: jdk-16

include ${DOT_ROOT}/install/_common.mk

jdk-16: ${DOT_ROOT}/tmp/jdk-16
${DOT_ROOT}/tmp/jdk-16: ${DOT_ROOT}/tmp/jdk-16.tgz jenv
	tar xzvf $< --directory ${DOT_ROOT}/tmp
	${JENV_PATH}/bin/jenv init -
	${JENV_PATH}/bin/jenv add $@
	${JENV_PATH}/bin/jenv global openjdk64-16

${DOT_ROOT}/tmp/jdk-16.tgz: wget
	wget https://download.java.net/java/GA/jdk16/7863447f0ab643c585b9bdebf67c69db/36/GPL/openjdk-16_linux-x64_bin.tar.gz -O $@

jenv: ${JENV_PATH}
${JENV_PATH}: git
	git clone https://github.com/jenv/jenv.git $@
