FROM docker.io/ysebastia/wget:1.21.3 as downloader

WORKDIR /tmp
RUN wget -q http://utils.ecole-navale.fr/phpcpd/phpcpd-6.0.3.phar -O /tmp/phpcpd

FROM php:8.1.7-cli-alpine3.16
COPY --from=downloader /tmp/phpcpd /usr/local/bin/phpcpd
RUN chmod +x /usr/local/bin/phpcpd
CMD ["/usr/local/bin/phpcpd"]