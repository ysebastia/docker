FROM ysebastia/pip-venv:24.3.1 AS builder
RUN pip install --no-cache-dir --use-pep517 \
  pylint==3.3.3 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM alpine:20240923
COPY --from=builder /venv /venv
ENV VIRTUAL_ENV=/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN apk add --no-cache \
  python3=3.12.8-r1
CMD ["/venv/bin/pylint"]
