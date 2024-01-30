FROM alpine:20230901 as builder
ENV VIRTUAL_ENV=/venv
RUN apk add --no-cache \
  py3-pip=23.3.2-r0 \
  py3-virtualenv=20.25.0-r0 \
  && python3 -m venv /venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip==23.3.2 \
  && pip install --no-cache-dir --use-pep517 \
  pylint==3.0.3 \
  && pip list -o \
  && find /usr/lib/ -name '*.pyc' -delete

FROM alpine:20230901
COPY --from=builder /venv /venv
ENV VIRTUAL_ENV=/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN apk add --no-cache \
  python3=3.11.7-r1
CMD ["/venv/bin/pylint"]
