FROM alpine:3

RUN apk add --no-cache \
    git=2.34.2-r0 \
    make=4.3-r0

RUN apk add --no-cache \
    python3=3.9.7-r4 \
    py3-pip=20.3.4-r1

COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir --requirement /tmp/requirements.txt
