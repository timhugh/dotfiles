DOT_ROOT ?= $(shell git rev-parse --show-toplevel)
GO_VERSION ?= 1.19.5
PLATFORM ?= linux-amd64

.PHONY: golang
golang: /usr/local/go

include ${DOT_ROOT}/install/_common.mk

/usr/local/go: ${DOT_ROOT}/tmp/go${GO_VERSION}.${PLATFORM}.tar.gz
	sudo tar -C /usr/local -xzvf $<
${DOT_ROOT}/tmp/go${GO_VERSION}.${PLATFORM}.tar.gz: wget
	wget -O $@ https://golang.org/dl/go${GO_VERSION}.${PLATFORM}.tar.gz
