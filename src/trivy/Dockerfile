FROM docker.io/ysebastia/wget:1.21.4-r0-2 as downloader

RUN wget -q https://github.com/aquasecurity/trivy/releases/download/v0.45.1/trivy_0.45.1_Linux-64bit.tar.gz -O trivy.tar.gz && tar xzf trivy.tar.gz

FROM alpine:20230901
COPY --from=downloader /tmp/trivy /usr/local/bin/trivy
COPY --from=downloader /tmp/contrib/*.tpl /tmp/contrib/
RUN chmod +x /usr/local/bin/trivy
CMD ["/usr/local/bin/trivy"]
