FROM node:13.7.0-alpine3.11
LABEL image="node"
LABEL versie="0.1"
LABEL datum="2020 01 23"

RUN npm install -g @loopback/cli \
  && npm install -g jsonwebtoken

# setup user
USER node

# Create app directory (with user `node`)
RUN mkdir -p /home/node/app

WORKDIR /home/node/app

# dummy app
COPY --chown=node app .

# copy script to configure loopback
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

# Bind to all network interfaces so that it can be mapped to the host OS
ENV HOST=0.0.0.0 PORT=3000

EXPOSE ${PORT}
CMD [ "node", "."]
