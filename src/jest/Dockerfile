FROM node:lts-alpine3.19
RUN npm install -g npm@10.2.5 \
  && npm install -g \
  jest-environment-jsdom@29.7.0 \
  jest-junit@16.0.0 \
  jest@29.7.0
CMD ["/usr/local/bin/jest"]
