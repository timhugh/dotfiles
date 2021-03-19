DOT_ROOT ?= $(shell git rev-parse --show-toplevel)
JENV_PATH = ${HOME}/.jenv

.PHONY: java
java: jdk-11.0.2 gradle

include ${DOT_ROOT}/install/_common.mk

jdk-16: ${DOT_ROOT}/tmp/jdk-16 jenv
	${JENV_PATH}/bin/jenv add ${DOT_ROOT}/tmp/$@
${DOT_ROOT}/tmp/jdk-16: ${DOT_ROOT}/tmp/jdk-16.tgz jenv
	test -d $@ || tar xzvf $< --directory ${DOT_ROOT}/tmp
${DOT_ROOT}/tmp/jdk-16.tgz: wget
	mkdir -p ${DOT_ROOT}/tmp
	test -f $@ || wget https://download.java.net/java/GA/jdk16/7863447f0ab643c585b9bdebf67c69db/36/GPL/openjdk-16_linux-x64_bin.tar.gz -O $@

jdk-11.0.2: ${DOT_ROOT}/tmp/jdk-11.0.2 jenv
	${JENV_PATH}/bin/jenv add ${DOT_ROOT}/tmp/$@
${DOT_ROOT}/tmp/jdk-11.0.2: ${DOT_ROOT}/tmp/jdk-11.0.2.tgz
	test -d $@ || tar xzvf $< --directory ${DOT_ROOT}/tmp
${DOT_ROOT}/tmp/jdk-11.0.2.tgz: wget
	mkdir -p ${DOT_ROOT}/tmp
	test -f $@ || wget https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_linux-x64_bin.tar.gz -O $@

jenv: ${JENV_PATH}
	$</bin/jenv init -
${JENV_PATH}: git
	test -d $@ || git clone https://github.com/jenv/jenv.git $@

gradle: ${HOME}/.gradle
${HOME}/.gradle: ${DOT_ROOT}/tmp/gradle.zip unzip
	test -d $@ || unzip -d $@ $<

${DOT_ROOT}/tmp/gradle.zip: wget
	mkdir -p ${DOT_ROOT}/tmp
	test -f $@ || wget https://downloads.gradle-dn.com/distributions/gradle-6.8.3-bin.zip -O $@