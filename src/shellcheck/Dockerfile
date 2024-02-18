FROM alpine:20230901
RUN apk add --no-cache \
  file=5.45-r1 \
  git=2.43.2-r0 \
  shellcheck=0.9.0-r5 \
  xmlstarlet=1.6.1-r2
COPY checkstyle2junit.xslt /usr/local/share/
COPY shellcheck.bash /usr/local/bin/
COPY shellcheck2junit.bash /usr/local/bin/
RUN chmod +x /usr/local/bin/*.bash
CMD ["/usr/bin/shellcheck"]
