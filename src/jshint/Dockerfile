FROM node:lts-alpine3.20
RUN npm install -g npm@10.9.2 \
  && npm install -g \
  jshint@2.13.6 \
  jshint-junit-reporter@0.2.3  \
   && npm outdated
CMD ["/usr/local/bin/jshint"]
