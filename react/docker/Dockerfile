FROM node:14-alpine3.14 AS build
RUN apk update
RUN apk add --no-cache 'git>2.30.0'
# Install dependencies required for node-gyp (Python, make, g++, etc.)
RUN apk add --no-cache python2 make g++ \
    && ln -sf /usr/bin/python2 /usr/bin/python

ARG WORK_DIR
WORKDIR /app
ENV NODE_OPTIONS="--max-old-space-size=8168"

COPY ${WORK_DIR} .
RUN ls -lah


RUN ls
RUN yarn install
RUN yarn build

COPY ./example/src ${WORK_DIR}/src
COPY ./example/public ${WORK_DIR}/public

RUN  ls
RUN yarn buildW:webpack

FROM nginx:mainline-alpine
ENV WORK_DIR=/var/web/core-ui

RUN mkdir -p ${WORK_DIR}

COPY --from=build /app/build ${WORK_DIR}/
COPY --from=build /app/docker/nginx.conf /etc/nginx/conf.d/default.conf
