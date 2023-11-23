FROM node:lts-alpine3.18
RUN npm install -g npm@10.2.4 \
  && npm install -g \
  jest-environment-jsdom@29.6.1 \
  jest-junit@16.0.0 \
  jest@29.6.1
CMD ["/usr/local/bin/jest"]
