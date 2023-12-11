FROM node:lts-alpine3.19
RUN npm install -g npm@10.2.5 \
  && npm install -g \
  jshint@2.13.6 \
  jshint-junit-reporter@0.2.3
CMD ["/usr/local/bin/jshint"]
