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
DOCKER_IMAGE ?= shipmate
DOCKER_SHELLFLAGS ?= run --rm -it -e IF0_ENVIRONMENT=${IF0_ENVIRONMENT} --name shipmate-${IF0_ENVIRONMENT} -v ${HOME}/.ssh:/root/.ssh -v ${PWD}:/shipmate -v ${HOME}/.if0/.environments/${IF0_ENVIRONMENT}:/root/.if0/.environments/zero -v ${HOME}/.if0/.environments/${IF0_ENVIRONMENT}:/cargo -v ${HOME}/.gitconfig:/root/.gitconfig ${DOCKER_IMAGE}
export SHIPMATE_PROVIDERS ?= version
export GL_TOKEN ?= 
ENVIRONMENT_DIR ?= ${HOME}/.if0/.environments/zero
ANSIBLE_V ?= 

.PHONY: help
help:
>	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: load
load: /tmp/.loaded.sentinel

/tmp/.loaded.sentinel: $(shell find ${ENVIRONMENT_DIR} -type f -name '*.env') ## help
> @if [ ! -z $$IF0_ENVIRONMENT ]; then echo "Loading Environment ${IF0_ENVIRONMENT}"; fi
> @if [ ! -z $$DASH1_MODULE ]; then echo "Loading Provider ${DASH1_MODULE}"; else echo "No Provider selected. Exit."; exit 1; fi
> @touch /tmp/.loaded.sentinel

.PHONY: ship
ship: ${CARGO_DIR}/VERSION.txt

${CARGO_DIR}/VERSION.txt: 
>	@ansible-playbook /shipmate/playbooks/ahoi.yml ${ANSIBLE_V}

.PHONY: stuff
stuff:
> @ansible-playbook /shipmate/shipmate.yml ${ANSIBLE_V}

.PHONY: retry
retry:
> @ansible-playbook provision.yml --limit @/root/.ansible/.retry/provision.retry

# Development
.PHONY: build
build:
> @docker build --pull -t shipmate .

.PHONY: run
run: .SHELLFLAGS = ${DOCKER_SHELLFLAGS}
run: SHELL := docker
run:
> @bash

.PHONY: ssh
ssh: ${ENVIRONMENT_DIR}/.ssh/id_rsa ${ENVIRONMENT_DIR}/.ssh/id_rsa.pub

.PHONY: inventory
inventory:
> @python inventory/zero.py --list | jq