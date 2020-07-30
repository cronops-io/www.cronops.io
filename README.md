<div align="left">
    <img src="./%40figures/cronops-isologo-simple.png" alt="CronOps" width="350"/>
</div>

# www.cronops.io

Built with <a href="https://www.gatsbyjs.org/" target="_blank">Gatsby</a> and most of the credits to https://github.com/bchiang7/v4

## 🛠 Run the local environment with docker-compose
### Local Environment

* Setup Local Env vars
```
DOCKER_ENV              := dev
DOCKER_COMPOSE_FILE     := docker-compose-${DOCKER_ENV}.yaml
DOCKER_COMPOSE_CMD      := COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 docker-compose -f ${DOCKER_COMPOSE_FILE}
DOCKER_PRD_RELEASE_TAG  := v0.0.1
```

* Update your NodeJs dependencies file
   1. Update /package.json
   2. Update `yarn.lock` w/ `make yarn-import` cmd

* Spin up the local environment in background (detached) mode:
```bash
make up
```
This won't show any containers verbose output (if needed just `docker-compose up`), so you will have to wait until the
local server is up navigate to `http://localhost:8000` (if `DOCKER_ENV := prd` then `http://localhost:80`) in your
web browser.

* Check running containers with docker-compose:
```bash
make ps
```

* Stop and remove the containers:
```bash
make stop
```

* To check all the `Makafile` available cmds just type:
```bash
make
```

## 🚀 Create a production image build via docker
```
make prd-build-image
```
- **CONSIDERATION:** `DOCKER_PRD_RELEASE_TAG` Makefile var should be updated with the proper release semver tag
eg: `v0.0.1`

## Run local environment without docker/docker-compose
* Make sure you have the following dependencies installed in your system:
  * node    >= v14.1.0
  * npm     >= v6.14.4
  * yarn    >= v1.22.4

* Generate yarn.lock dependencies:
```bash
yarn import
```

## 🛠 Installation & Set Up without Docker

1. Install the Gatsby CLI

   ```sh
   npm install -g gatsby-cli
   ```

2. Install and use the correct version of Node using [NVM](https://github.com/nvm-sh/nvm)

   ```sh
   nvm install
   ```

3. Install dependencies

   ```sh
   yarn
   ```

4. Start the development server

   ```sh
   npm start
   ```

## 🚀 Building and Running for Production

1. Generate a full static production build

   ```sh
   npm run build
   ```

1. Preview the site as it will appear once deployed

   ```sh
   npm run serve
   ```

## 🎨 Color Reference

| Color          | Hex                                                                |
| -------------- | ------------------------------------------------------------------ |
| Navy           | ![#0a192f](https://via.placeholder.com/10/0a192f?text=+) `#0a192f` |
| Light Navy     | ![#172a45](https://via.placeholder.com/10/0a192f?text=+) `#172a45` |
| Lightest Navy  | ![#303C55](https://via.placeholder.com/10/303C55?text=+) `#303C55` |
| Slate          | ![#8892b0](https://via.placeholder.com/10/8892b0?text=+) `#8892b0` |
| Light Slate    | ![#a8b2d1](https://via.placeholder.com/10/a8b2d1?text=+) `#a8b2d1` |
| Lightest Slate | ![#ccd6f6](https://via.placeholder.com/10/ccd6f6?text=+) `#ccd6f6` |
| White          | ![#e6f1ff](https://via.placeholder.com/10/e6f1ff?text=+) `#e6f1ff` |
| Green          | ![#64ffda](https://via.placeholder.com/10/64ffda?text=+) `#64ffda` |
