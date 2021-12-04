DOT_ROOT ?= $(shell git rev-parse --show-toplevel)

.PHONY: docker
docker: docker-ce docker-ce-cli containerd.io docker-compose docker-permissions

include ${DOT_ROOT}/install/_common.mk

.PHONY: docker-ce
docker-ce: docker-apt-repository apt-update
	command -v $@ || sudo apt install -y $@

.PHONY: docker-ce-cli
docker-ce-cli: docker-apt-repository apt-update
	command -v $@ || sudo apt install -y $@

.PHONY: containerd.io
containerd.io: docker-apt-repository apt-update
	command -v $@ || sudo apt install -y $@

.PHONY: docker-compose
docker-compose: python3-pip
	command -v $@ || pip3 install docker-compose

.PHONY: docker-permissions
docker-permissions:
	sudo groupadd docker || true
	sudo usermod -aG docker ${USER}
	@echo "User ${USER} added to group docker. Log out and back in for permissions to take effect"

distro=$(shell lsb_release -is | tr '[:upper:]' '[:lower:]')
release=$(shell lsb_release -cs)

.PHONY: docker-apt-repository
docker-apt-repository: curl apt-transport-https lsb-release ca-certificates gnupg
	curl -fsSL https://download.docker.com/linux/$(distro)/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/$(distro) $(release) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt-get update
