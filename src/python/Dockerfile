FROM ysebastia/pip-venv:25.0.1-alpine AS builder
RUN pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM alpine:20240923
COPY --from=builder /venv /venv
ENV VIRTUAL_ENV=/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN apk add --no-cache \
  curl=8.12.1-r1 \
  git=2.49.0-r0 \
  python3=3.12.9-r0 \
