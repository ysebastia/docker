FROM node:lts-alpine3.20
RUN npm install -g npm@10.9.2 \
  && npm install -g \
  jest-environment-jsdom@29.7.0 \
  jest-junit@16.0.0 \
  jest@29.7.0
CMD ["/usr/local/bin/jest"]
