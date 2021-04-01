DOT_ROOT ?= $(shell git rev-parse --show-toplevel)

# invoking this file by itself is a no-op
.PHONY: nothing
nothing:

.PHONY: hub
hub: apt-update git
	command -v $@ || sudo apt install -y $@
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
.PHONY: openssh-client
openssh-client: apt-update
	sudo apt install -y $@
.PHONY: apt-transport-https
apt-transport-https: apt-update
	command -v $@ || sudo apt install -y $@
.PHONY: ca-certificates
ca-certificates: apt-update
	command -v $@ || sudo apt install -y $@
.PHONY: gnupg
gnupg: apt-update
	command -v $@ || sudo apt install -y $@
.PHONY: lsb-release
lsb-release: apt-update
	command -v $@ || sudo apt install -y $@

.PHONY: apt-update
apt-update:
	sudo apt update
