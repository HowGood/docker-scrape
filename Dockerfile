FROM gliderlabs/alpine:latest

RUN apk --no-cache add \
      bash \
      openssl \
      python \
      python-dev \
      py-pip \
      iptables \
      build-base \
  && pip install --no-cache-dir --upgrade pip

RUN echo '@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
  && apk --no-cache add \
        tor@testing \
        torsocks@testing

COPY torrc /etc/tor/torrc
COPY bootstrap /usr/local/bin/bootstrap
RUN chmod +x /usr/local/bin/bootstrap

ENTRYPOINT ["/usr/local/bin/bootstrap"]
