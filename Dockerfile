FROM    alpine:latest
LABEL   authors="Brendan Kerrigan <kerriganb@ainfosec.com>"

RUN     apk --no-cache add --update bash sudo nano 'su-exec>=0.2'

# Download and install runit
RUN     buildDeps='git make gcc g++ musl-dev gnu-efi gnu-efi-dev elfutils-dev' \
        && set -x \
        && apk add --update $buildDeps \
        && mkdir -p /src \
        && cd /src \
        && rm -rf /var/cache/apk/* 

RUN     mkdir -p /usr/lib/gnuefi \
        && cp /usr/lib/crt0-efi-x86_64.o /usr/lib/gnuefi \
        && mkdir -p /build

RUN     git clone -b measure https://github.com/ainfosec/shim.git
ENV     LIBDIR=/usr/lib
ENV     DESTDIR=/build
ENV     EFIDIR=/build
WORKDIR /shim
CMD [ "make", "install" ]
