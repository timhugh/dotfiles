DOT_ROOT ?= $(shell git rev-parse --show-toplevel)
RUBY_VERSION ?= 3.3.0
CHRUBY_VERSION ?= 0.3.9
RUBY_INSTALL_VERSION ?= 0.9.3

.PHONY: ruby
ruby: ruby-${RUBY_VERSION} chruby ${HOME}/.ruby-version ruby-gems

include ${DOT_ROOT}/install/_common.mk

.PHONY: ruby-${RUBY_VERSION}
ruby-${RUBY_VERSION}: ${HOME}/.rubies/ruby-${RUBY_VERSION}

${HOME}/.rubies/ruby-${RUBY_VERSION}: ruby-install
		ruby-install ruby ${RUBY_VERSION} -s ${DOT_ROOT}/tmp/

.PHONY: chruby
chruby: /usr/local/bin/chruby-exec
/usr/local/bin/chruby-exec: ${DOT_ROOT}/tmp/chruby-${CHRUBY_VERSION}
	sudo $(MAKE) -C ${DOT_ROOT}/tmp/chruby-${CHRUBY_VERSION} install
${DOT_ROOT}/tmp/chruby-${CHRUBY_VERSION}: ${DOT_ROOT}/tmp/chruby-${CHRUBY_VERSION}.tar.gz
	tar -xzvf $< -C ${DOT_ROOT}/tmp
${DOT_ROOT}/tmp/chruby-${CHRUBY_VERSION}.tar.gz:
	mkdir -p ${DOT_ROOT}/tmp
	test -f $@ || wget -O $@ https://github.com/postmodern/chruby/archive/v${CHRUBY_VERSION}.tar.gz

.PHONY: ruby-install
ruby-install: /usr/local/bin/ruby-install
/usr/local/bin/ruby-install: ${DOT_ROOT}/tmp/ruby-install-${RUBY_INSTALL_VERSION}
	sudo $(MAKE) -C ${DOT_ROOT}/tmp/ruby-install-${RUBY_INSTALL_VERSION} install
${DOT_ROOT}/tmp/ruby-install-${RUBY_INSTALL_VERSION}: ${DOT_ROOT}/tmp/ruby-install-${RUBY_INSTALL_VERSION}.tar.gz
	tar -xzvf $< -C ${DOT_ROOT}/tmp
${DOT_ROOT}/tmp/ruby-install-${RUBY_INSTALL_VERSION}.tar.gz:
	mkdir -p ${DOT_ROOT}/tmp
	test -f $@ || wget -O $@ https://github.com/postmodern/ruby-install/archive/v${RUBY_INSTALL_VERSION}.tar.gz

${HOME}/.ruby-version:
	echo ruby-${RUBY_VERSION} > $@

.PHONY: ruby-gems
ruby-gems:
	gem install bundler solargraph rubocop
	gem update --system
