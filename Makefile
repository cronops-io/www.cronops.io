.PHONY: help
SHELL             := /bin/bash
LOCAL_OS_USER_ID  := $(shell id -u)
LOCAL_OS_GROUP_ID := $(shell id -g)

# setup your env tier: dev || prd
DOCKER_ENVIRONMENT  := dev
DOCKER_COMPOSE_FILE := docker-compose-${DOCKER_ENVIRONMENT}.yaml
DOCKER_COMPOSE_CMD  := COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 docker-compose -f ${DOCKER_COMPOSE_FILE}
DOCKER_IMAGE_NAME   := cronopsio
DOCKER_RELEASE_TAG  := v0.0.1

help:
	@echo 'Available Commands:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf " - \033[36m%-18s\033[0m %s\n", $$1, $$2}'

#==============================================================#
# CIRCLECI                                                     #
#==============================================================#
circleci-validate-config: ## Validate A CircleCI Config (https://circleci.com/docs/2.0/local-cli/)
	circleci config validate .circleci/config.yml

#==============================================================#
# DOCKER-COMPOSE                                               #
#==============================================================#
build: ## Build local environment images
	sudo chown -R ${LOCAL_OS_USER_ID}:${LOCAL_OS_GROUP_ID} -R .
	${DOCKER_COMPOSE_CMD} build

build-no-cache: ## Build local environment images --no-cache
	sudo chown -R ${LOCAL_OS_USER_ID}:${LOCAL_OS_GROUP_ID} -R .
	${DOCKER_COMPOSE_CMD} build --no-cache

build-prd: ## Build local environment prd images
	DOCKER_BUILDKIT=1 docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_RELEASE_TAG} --target prd .

up: ## Start local environment (docker-compose up -d)
	${DOCKER_COMPOSE_CMD} up -d

stop: ## Stop local environment
	${DOCKER_COMPOSE_CMD} down
	sudo chown -R ${LOCAL_OS_USER_ID}:${LOCAL_OS_GROUP_ID} -R .

rm: ## Stop and remove all local environment containers
	${DOCKER_COMPOSE_CMD} stop
	${DOCKER_COMPOSE_CMD} rm --force

ps: ## Show running containers status
	${DOCKER_COMPOSE_CMD} ps

app-logs: ## Show boostrap-vue env logs
	${DOCKER_COMPOSE_CMD} logs --tail=10 bb-web-${DOCKER_ENVIRONMENT}

app-sh: ## Get into bootstrap-vue container through a shell
	${DOCKER_COMPOSE_CMD} exec bb-web-${DOCKER_ENVIRONMENT} bash

deploy-dist-aws: ## Deploy builded version to AWS || eg: make APP_ENVIRONMENT="dev" deploy-dist-aws
	DOCKER_BUILDKIT=1 docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_RELEASE_TAG} --target prd .
	docker run -d --name "${DOCKER_IMAGE_NAME}-${DOCKER_RELEASE_TAG}" ${DOCKER_IMAGE_NAME}:${DOCKER_RELEASE_TAG}
	docker cp ${DOCKER_IMAGE_NAME}-${DOCKER_RELEASE_TAG}:/usr/share/nginx/html/ ./dist/
	docker rm ${DOCKER_IMAGE_NAME}-${DOCKER_RELEASE_TAG} --force
	bash @bin/scripts/bb-le-apps-s3-sync.sh ${APP_ENVIRONMENT}

#==============================================================#
# NODEJS                                                       #
#==============================================================#
yarn-import: ## Recreate yarn.lock with lastest package.json state (keeping a temp backup)
	yarn -v # step to validate that yarn binary is installed and in your $PATH
	cp yarn.lock yarn.lock.back
	rm yarn.lock
	npm install -g npm
	npm install && npm audit fix && rm package-lock.json
	yarn import # create yarn.lock form package.json
	@if [ ! -f ./yarn.lock ]; then\
		cp yarn.lock.back yarn.lock;\
		echo "=========================================================";\
    	echo "yarn.lock creation FAILED, please check the output error ";\
		echo "=========================================================";\
	else\
		echo "=========================================================";\
    	echo "yarn.lock with updated dependencies SUCCESSFULLY created ";\
		echo "=========================================================";\
	fi
