FROM docker.io/ysebastia/wget:1.21.3-r2 as downloader

WORKDIR /tmp
RUN wget -q https://github.com/phpmd/phpmd/releases/download/2.13.0/phpmd.phar -O /tmp/phpmd

FROM php:8.1.11-cli-alpine3.16
COPY --from=downloader /tmp/phpmd /usr/local/bin/phpmd
RUN chmod +x /usr/local/bin/phpmd
CMD ["/usr/local/bin/phpmd"]
