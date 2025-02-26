FROM alpine:20240923
RUN apk add --no-cache \
  file=5.46-r0 \
  git=2.48.1-r0 \
  shellcheck=0.10.0-r1 \
  xmlstarlet=1.6.1-r2
COPY checkstyle2junit.xslt /usr/local/share/
COPY shellcheck.bash /usr/local/bin/
COPY shellcheck2junit.bash /usr/local/bin/
RUN chmod +x /usr/local/bin/*.bash
CMD ["/usr/bin/shellcheck"]
