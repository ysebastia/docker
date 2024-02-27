FROM alpine:20230901 as builder
ENV VIRTUAL_ENV=/venv
RUN apk add --no-cache \
  py3-pip=24.0-r0 \
  py3-virtualenv=20.25.0-r0 \
  py3-wheel=0.42.0-r0 \
  && python3 -m venv /venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip==24.0 \
  && pip install --no-cache-dir --use-pep517 \
  ansible-core==2.16.4 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM alpine:20230901
COPY --from=builder /venv /venv
ENV VIRTUAL_ENV=/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN apk add --no-cache \
  curl=8.6.0-r0 \
  git=2.44.0-r0 \
  python3=3.11.8-r0 \
  && mkdir -p /.cache /.ansible \
  && chmod 777 /.cache /.ansible
CMD ["/venv/bin/ansible-lint"]
