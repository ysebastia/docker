FROM docker.io/ysebastia/wget:1.25.0-r1 AS downloader

RUN wget -q https://github.com/aquasecurity/trivy/releases/download/v0.60.0/trivy_0.60.0_Linux-64bit.tar.gz -O trivy.tar.gz && tar xzf trivy.tar.gz

FROM alpine:20240923
COPY --from=downloader /tmp/trivy /usr/local/bin/trivy
COPY --from=downloader /tmp/contrib/*.tpl /tmp/contrib/
RUN chmod +x /usr/local/bin/trivy \
    && trivy image --download-db-only --cache-dir /tmp/.cache \
    && chmod -R 777 /tmp/.cache
CMD ["/usr/local/bin/trivy"]
