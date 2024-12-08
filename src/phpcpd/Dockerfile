FROM docker.io/ysebastia/wget:1.25.0-r0 AS downloader

RUN wget -q https://phar.phpunit.de/phpcpd-6.0.3.phar -O /tmp/phpcpd

FROM php:8.1.31-cli-alpine3.19
COPY --from=downloader /tmp/phpcpd /usr/local/bin/phpcpd
RUN chmod +x /usr/local/bin/phpcpd
CMD ["/usr/local/bin/phpcpd"]
