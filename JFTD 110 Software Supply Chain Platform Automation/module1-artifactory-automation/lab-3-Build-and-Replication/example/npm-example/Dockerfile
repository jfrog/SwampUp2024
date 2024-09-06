FROM node:alpine

ENV APP_HOME="/app"

WORKDIR ${APP_HOME}

COPY package*.json ${APP_HOME}/
COPY . ${APP_HOME}

RUN --mount=type=secret,id=npmrc,target=/root/.npmrc npm install

EXPOSE 3000

CMD ["npm", "start"]