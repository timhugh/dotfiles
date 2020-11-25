DOT_ROOT ?= $(shell git rev-parse --show-toplevel)

# so this make file doesn't go weird if you call it alone
.PHONY: nothing
nothing:

.PHONY: git
git: apt-update
	command -v $@ || sudo apt install -y $@
.PHONY: curl
curl: apt-update
	command -v $@ || sudo apt install -y $@
.PHONY: wget
wget: apt-update
	command -v $@ || sudo apt install -y $@
.PHONY: fzf
fzf: apt-update
	command -v $@ || sudo apt install -y $@
.PHONY: silversearcher-ag
silversearcher-ag: apt-update
	command -v ag || sudo apt install -y $@
.PHONY: cmake
cmake: apt-update
	command -v $@ || sudo apt install -y $@
.PHONY: pkg-config
pkg-config: apt-update
	command -v $@ || sudo apt install -y $@
.PHONY: libtool
libtool: apt-update
	command -v libtoolize || sudo apt install -y $@
.PHONY: libtool-bin
libtool-bin: apt-update
	command -v libtool || sudo apt install -y $@
.PHONY: automake
automake: apt-update
	command -v $@ || sudo apt install -y $@
.PHONY: unzip
unzip: apt-update
	command -v $@ || sudo apt install -y $@
.PHONY: gettext
gettext: apt-update
	command -v $@ || sudo apt install -y $@
.PHONY: build-essential
build-essential: apt-update
	sudo apt install -y $@
.PHONY: clangd
clangd: apt-update
	command -v $@ || (\
		sudo apt install -y clangd-8 && \
		sudo ln -s /usr/bin/clangd-8 /usr/bin/clangd \
	)

.PHONY: apt-update
apt-update:
	sudo apt update
