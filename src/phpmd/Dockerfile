FROM php:7.4.27-cli-alpine3.15
RUN apk add --no-cache wget
RUN wget -q --no-check-certificate https://github.com/phpmd/phpmd/releases/download/2.11.1/phpmd.phar \
	&& mv phpmd.phar /usr/local/bin/phpmd \
	&& chmod +x /usr/local/bin/phpmd
CMD ["/usr/local/bin/phpmd"]