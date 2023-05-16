FROM alpine:20230329 as builder
ENV VIRTUAL_ENV=/venv
RUN apk add --no-cache \
  py3-pip=23.1.2-r0 \
  py3-virtualenv=20.23.0-r0 \
  py3-wheel=0.40.0-r1 \
  && python3 -m venv /venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip==23.1.2 \
  && pip install --no-cache-dir --use-pep517 \
  ansible-core==2.15.0 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM alpine:20230329
COPY --from=builder /venv /venv
ENV VIRTUAL_ENV=/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN apk add --no-cache \
  curl=8.0.1-r3 \
  git=2.40.1-r0 \
  python3=3.11.3-r11 \
  && mkdir -p /.cache /.ansible \
  && chmod 777 /.cache /.ansible
CMD ["/venv/bin/ansible-lint"]