FROM node:14.16-alpine AS build

# Get the necessary build tools
RUN apk update && apk add build-base autoconf automake libtool pkgconfig nasm
RUN npm install -g gatsby-cli

WORKDIR /app
RUN chmod -R 777 /app

COPY ./package*.json ./
COPY ./gatsby-config.js ./

RUN npm install && gatsby telemetry --disable

COPY ./ ./

RUN npm run build

CMD ["npm", "run", "start"]