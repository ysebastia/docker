FROM docker.io/ysebastia/wget:1.21.3-r3 as downloader

WORKDIR /tmp
RUN wget -q https://github.com/squizlabs/PHP_CodeSniffer/releases/download/3.7.2/phpcs.phar -O /tmp/phpcs

FROM php:8.1.16-fpm-alpine3.17
COPY --from=downloader /tmp/phpcs /usr/local/bin/phpcs
RUN chmod +x /usr/local/bin/phpcs
CMD ["/usr/local/bin/phpcs"]
