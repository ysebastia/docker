FROM docker.io/ysebastia/wget:1.24.5-r0 as downloader

RUN wget -q https://github.com/squizlabs/PHP_CodeSniffer/releases/download/3.7.2/phpcs.phar -O /tmp/phpcs

FROM php:8.1.27-cli-alpine3.19
COPY --from=downloader /tmp/phpcs /usr/local/bin/phpcs
RUN chmod +x /usr/local/bin/phpcs
CMD ["/usr/local/bin/phpcs"]
