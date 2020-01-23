FROM node:13.7.0-alpine3.11
LABEL image="node"
LABEL versie="0.1"
LABEL datum="2020 01 23"

# setup user
USER node

# Create app directory (with user `node`)
RUN mkdir -p /home/node/app

WORKDIR /home/node/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY --chown=node app/package*.json ./

USER root

RUN npm install \
  && npm install -g @loopback/cli \
  && npm install -g jsonwebtoken

USER node

# Bundle app source code
COPY --chown=node app . 

# for loopback app only not for helloworld server
#RUN npm run build

# Bind to all network interfaces so that it can be mapped to the host OS
ENV HOST=0.0.0.0 PORT=3000

EXPOSE ${PORT}
CMD [ "node", ".", "&"]
