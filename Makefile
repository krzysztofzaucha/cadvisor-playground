export SHELL:=/bin/bash
export BASE_NAME:=$(shell basename ${PWD})
export IMAGE_BASE_NAME:=kz/$(shell basename ${PWD})
export NETWORK:=${BASE_NAME}-network

default: help

help: ## Prints help for targets with comments
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' ${MAKEFILE_LIST} | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-50s\033[0m %s\n", $$1, $$2}'
	@echo ""

#########
# Build #
#########

clone: clean
	@mkdir -p tmp/google
	@# Original repo: https://github.com/google/cadvisor/archive/refs/heads/master.zip
	@curl -Ls \
	  -H "authorization: token ${GITHUB_TOKEN}" \
	  -o tmp/google/cadvisor.zip https://github.com/Creatone/cadvisor/archive/refs/heads/creatone/podman.zip
	@unzip -q tmp/google/cadvisor.zip -d tmp/google || true

build: clone
	@podman image build \
		-t "${IMAGE_BASE_NAME}-cadvisor:latest" \
		-f "cadvisor/Dockerfile" \
		tmp/google/cadvisor-creatone-podman

clean:
	@rm -R -f tmp

#######
# Run #
#######

compose:
	@podman-compose ${COMPOSE} \
		-p ${BASE_NAME} \
		up -d --build --force-recreate --remove-orphans --abort-on-container-exit

up: clone ## Start the example
	@COMPOSE=" -f docker-compose.yml" make compose

down: ## Stop whatever is running
	@podman stop $(shell podman ps -aq) || true
	@podman system prune || true

###############
# Danger Zone #
###############

reset: ## Cleanup
	@podman stop $(shell podman ps -aq) || true
	@podman system prune || true
	@podman volume rm $(shell podman volume ls -q) || true
	@podman rmi -f ${IMAGE_BASE_NAME}-grafana:latest || true
	@podman rmi -f ${IMAGE_BASE_NAME}-cadvisor:latest || true
	@podman rmi -f ${IMAGE_BASE_NAME}-ping:latest || true
