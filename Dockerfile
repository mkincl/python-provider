FROM alpine:3.16

RUN apk add --no-cache \
    git=2.36.1-r0 \
    make=4.3-r0

RUN apk add --no-cache \
    python3=3.10.4-r0 \
    py3-pip=22.1.1-r0

COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir --requirement /tmp/requirements.txt
