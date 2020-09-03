SHELL := bash
.ONESHELL:
#.SILENT:
.SHELLFLAGS := -eu -o pipefail -c
#.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
.DEFAULT_GOAL := help

ifeq ($(origin .RECIPEPREFIX), undefined)
  $(error This Make does not support .RECIPEPREFIX. Please use GNU Make 4.0 or later)
endif
.RECIPEPREFIX = >

export DOCKER_BUILDKIT=1
IF0_ENVIRONMENT ?= zero
DOCKER_BASE_IMAGE ?= registry.gitlab.com/peter.saarland/ansible-boilerplate:latest
export DOCKER_IMAGE ?= shipmate
DOCKER_SHELLFLAGS ?= run --privileged --rm -it -v ${PWD}:/shipmate -v /var/run/docker.sock:/var/run/docker.sock -v ${PWD}:/cargo ${DOCKER_IMAGE}
export GL_TOKEN ?= 
ANSIBLE_V ?= 

.PHONY: help
help:
>	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: stuff
stuff:
> @ansible-playbook /shipmate/shipmate.yml ${ANSIBLE_V}

.PHONY: retry
retry:
> @ansible-playbook provision.yml --limit @/root/.ansible/.retry/provision.retry

.PHONY: tag
tag: ## Run 'tag' stage
> @export SHIPMATE_STAGE=tag
> @ansible-playbook /shipmate/shipmate.yml ${ANSIBLE_V}

.PHONY: build
build: ## Run 'build' stage
> @export SHIPMATE_STAGE=build
> @ansible-playbook /shipmate/shipmate.yml ${ANSIBLE_V}

.PHONY: ship
ship: ## Run 'ship' stage
> @export SHIPMATE_STAGE=ship
> @ansible-playbook /shipmate/shipmate.yml ${ANSIBLE_V}

.PHONY: check
check: ## Run 'ship' stage
> @export SHIPMATE_STAGE=tag
> @ansible-playbook /shipmate/shipmate.yml ${ANSIBLE_V} --check



.PHONY: build-local
build-local: ## Development: build local Docker image
build-local: 
> @docker build --build-arg DOCKER_BASE_IMAGE=ansible-boilerplate -t shipmate .

.PHONY: dev
dev: .SHELLFLAGS = ${DOCKER_SHELLFLAGS}
dev: SHELL := docker
dev: ## Development: run local Docker image
> @bash

.PHONY: ssh
ssh: ${ENVIRONMENT_DIR}/.ssh/id_rsa ${ENVIRONMENT_DIR}/.ssh/id_rsa.pub ## Development: generate SSH Keys in Environment Directory

.PHONY: inventory
inventory: ## Development: list ansible inventory
> @ansible-inventory -i inventory/shipmate.yml --list | jq