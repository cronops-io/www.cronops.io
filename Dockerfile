#
# Stage: Base Build
#
FROM node:14.1.0-stretch-slim AS base-build
RUN mkdir /app
WORKDIR /app

RUN apt-get update && apt-get install -y libglu1 libxi6 && apt-get clean
RUN npm install -g gatsby-cli

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

# install and cache app dependencies using yarn
COPY package.json yarn.lock /app/
RUN yarn install --pure-lockfile && yarn cache clean

#
# Stage: Development
#
FROM base-build AS dev
# Copy all frontend stuff to new "app" folder
COPY . /app
WORKDIR /app
ENV HOST=0.0.0.0
CMD ["yarn", "develop", "-H", "0.0.0.0" ]

#
# Stage: Prd Build
#
FROM node:14.1.0-stretch-slim AS prd-build
COPY --from=dev /app /app
WORKDIR /app

RUN apt-get update && apt-get install -y libglu1 libxi6 && apt-get clean
RUN yarn build

#
# Stage: Production
#
FROM nginx:1.17.9 AS prd
COPY --from=prd-build /app/public /usr/share/nginx/html/
