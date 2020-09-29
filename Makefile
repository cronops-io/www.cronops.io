.PHONY: help
SHELL         := /bin/bash
MAKEFILE_PATH := ./Makefile
MAKEFILES_DIR := ./@bin/makefiles

PROJECT_ID := co
APP_ENV_ID := ${PROJECT_ID}-web

# setup your env tier: dev || prd
DOCKER_ENVIRONMENT  := dev
DOCKER_IMAGE_NAME   := www-cronops
DOCKER_RELEASE_TAG  := v0.0.1

# Project Deployment variables
PROJECT_URL := www.cronops.io
PROJECT_GIT := git@github.com:cronops-io/www.cronops.io.git

help:
	@echo 'Available Commands:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf " - \033[36m%-18s\033[0m %s\n", $$1, $$2}'

#==============================================================#
# INITIALIZATION                                               #
#==============================================================#
init-makefiles: ## initialize makefiles
	rm -rf ${MAKEFILES_DIR}
	mkdir -p ${MAKEFILES_DIR}
	git clone https://github.com/binbashar/le-dev-makefiles.git ${MAKEFILES_DIR}

-include ${MAKEFILES_DIR}/circleci/circleci.mk
-include ${MAKEFILES_DIR}/release-mgmt/release.mk
-include ${MAKEFILES_DIR}/docker/docker-compose-node.mk
-include ${MAKEFILES_DIR}/yarn/yarn.mk

deploy-dist-github: ## Deploy master branch dist/ to gh-pages branch
	cd dist &&\
	git init &&\
	echo "${PROJECT_URL}" > CNAME &&\
	git add --all . &&\
	git commit -m "Deploying latest code" &&\
	git push -f ${PROJECT_GIT} master:gh-pages
