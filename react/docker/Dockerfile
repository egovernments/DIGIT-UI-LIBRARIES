FROM node:14-alpine3.16 AS build
RUN apk update && apk upgrade
RUN apk add --no-cache git>2.30.0
ARG WORK_DIR
WORKDIR /app
ENV NODE_OPTIONS="--max-old-space-size=8168"

COPY ${WORK_DIR} .
RUN ls -lah

#RUN node web/envs.js
RUN  ls \
   && yarn install \
    && yarn build

COPY ./example/src ${WORK_DIR}/src
COPY ./example/public ${WORK_DIR}/public

RUN  ls \
    && yarn buildW:webpack

FROM nginx:mainline-alpine
#FROM ghcr.io/egovernments/nginx:mainline-alpine
ENV WORK_DIR=/var/web/core-ui

RUN mkdir -p ${WORK_DIR}

COPY --from=build /app/build ${WORK_DIR}/
COPY --from=build /app/docker/nginx.conf /etc/nginx/conf.d/default.conf
