FROM node:lts-alpine3.20
RUN npm install -g npm@10.9.2 \
  && npm install -g csslint@1.0.5 \
  && npm outdated
CMD ["/usr/local/bin/csslint"]