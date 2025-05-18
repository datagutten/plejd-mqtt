FROM node:24-alpine AS builder
ARG PACKAGE_VERSION=0.11.0

RUN \
  apk add --no-cache --virtual .build-dependencies \
  g++ \
  gcc \
  libc-dev \
  linux-headers \
  make \
  python3 \
  bluez \
  eudev-dev \
  zlib-dev \
  \
  && apk add --no-cache \
  git \
  dbus-dev \
  glib-dev


RUN git clone https://github.com/icanos/hassio-plejd --branch ${PACKAGE_VERSION}
WORKDIR /hassio-plejd/plejd
RUN npm install

FROM node:24-alpine
COPY --from=builder /hassio-plejd/plejd /plejd

CMD ["node", "/plejd/main.js"]