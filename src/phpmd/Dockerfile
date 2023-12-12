FROM docker.io/ysebastia/wget:1.21.4-r0-2 as downloader

RUN wget -q https://github.com/phpmd/phpmd/releases/download/2.14.1/phpmd.phar -O /tmp/phpmd

FROM php:8.1.26-cli-alpine3.18
COPY --from=downloader /tmp/phpmd /usr/local/bin/phpmd
RUN chmod +x /usr/local/bin/phpmd
CMD ["/usr/local/bin/phpmd"]
