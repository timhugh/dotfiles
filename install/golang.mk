DOT_ROOT ?= $(shell git rev-parse --show-toplevel)
GO_VERSION ?= 1.15.5

.PHONY: golang
golang: /usr/local/go

include ${DOT_ROOT}/install/_common.mk

/usr/local/go: ${DOT_ROOT}/tmp/go${GO_VERSION}.linux-amd64.tar.gz
	sudo tar -C /usr/local -xzvf $<
${DOT_ROOT}/tmp/go${GO_VERSION}.linux-amd64.tar.gz: wget
	wget -O $@ https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz
