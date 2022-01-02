FROM alpine:3.15.0
RUN apk add --no-cache ansible-lint=4.3.7-r4
COPY ansible-lint.bash /usr/local/bin/
RUN chmod +x /usr/local/bin/ansible-lint.bash
CMD ["/usr/bin/ansible-lint"]