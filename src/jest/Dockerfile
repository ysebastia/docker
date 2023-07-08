FROM node:lts-alpine3.18
RUN npm install -g npm@9.7.1 \
  && npm install -g \
  @testing-library/jest-dom@5.16.5 \
  jest-junit@16.0.0 \
  jest@29.6.1
CMD ["/usr/local/bin/jest"]
