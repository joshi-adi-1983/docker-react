FROM node:16-alpine as builder

USER node
 
RUN mkdir -p /home/node/app
WORKDIR /home/node/app
 
COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node ./ ./
 
RUN npm run build

# /home/node/app/build has the built files

FROM nginx

COPY --from=builder /home/node/app/build /usr/share/nginx/html

# no need to start nginx, it will be started by docker-compose