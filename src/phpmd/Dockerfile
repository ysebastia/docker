FROM docker.io/ysebastia/wget:1.25.0-r0 AS downloader

RUN wget -q https://github.com/phpmd/phpmd/releases/download/2.15.0/phpmd.phar -O /tmp/phpmd

FROM php:8.1.27-cli-alpine3.19
COPY --from=downloader /tmp/phpmd /usr/local/bin/phpmd
RUN chmod +x /usr/local/bin/phpmd
CMD ["/usr/local/bin/phpmd"]
