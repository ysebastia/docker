FROM alpine:20221110
RUN apk add --no-cache \
  shellcheck=0.8.0-r1 \
  file=5.43-r0
COPY shellcheck.bash /usr/local/bin/
RUN chmod +x /usr/local/bin/shellcheck.bash
CMD ["/usr/bin/shellcheck"]
