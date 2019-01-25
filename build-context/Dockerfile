FROM kdedesign/debian-stretch AS build

ARG GOGSVER=0.11.79
ARG GOVER=1.11.1
ENV GOPATH=/opt
ENV DEBIAN_FRONTEND noninteractive

# Update basic OS image
RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get install -y git gcc wget ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && wget https://dl.google.com/go/go${GOVER}.linux-armv6l.tar.gz -O /opt/go${GOVER}.linux-armv6l.tar.gz \
    && wget https://github.com/gogs/gogs/archive/v${GOGSVER}.tar.gz -O /opt/GOGS.tar.gz \
    && cd /opt \
    && tar -zxf ./go${GOVER}.linux-armv6l.tar.gz \
    && rm ./go${GOVER}.linux-armv6l.tar.gz \
    && mkdir -p $GOPATH/src/github.com/gogs/gogs \
    && cd $GOPATH/src/github.com/gogs/gogs \
    && tar -zxf /opt/GOGS.tar.gz --strip 1 \
    && rm /opt/GOGS.tar.gz \
    && cd $GOPATH/src/github.com/gogs/gogs \
    && /opt/go/bin/go build -tags "sqlite cert" \
    && groupadd -g 3000 git \
    && useradd -u 3000 -g 3000 -c "GIT user" -d /opt/gogs -s /bin/bash git \
    && mkdir -p /opt/gogs /data \
    && chown -R git:git /opt/src /data 


# Second stage
FROM kdedesign/debian-stretch

# Update basic OS image
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get install -y git \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd -g 3000 git \
    && useradd -u 3000 -g 3000 -c "GIT user" -d /opt/gogs  -s /bin/bash git \
    && mkdir -p /opt/gogs/custom /data \
    && chown -R git:git /opt/gogs /data

# Copy binaries files and config from first stage build
COPY --chown=3000:3000 --from=build /opt/src/github.com/gogs/gogs/gogs \
                                    /opt/src/github.com/gogs/gogs/LICENSE \
                                    /opt/src/github.com/gogs/gogs/README.md \
                                    /opt/src/github.com/gogs/gogs/README_ZH.md \
                                    /opt/gogs/

COPY --chown=3000:3000 --from=build /opt/src/github.com/gogs/gogs/public /opt/gogs/public
COPY --chown=3000:3000 --from=build /opt/src/github.com/gogs/gogs/scripts /opt/gogs/scripts
COPY --chown=3000:3000 --from=build /opt/src/github.com/gogs/gogs/templates /opt/gogs/templates

# Configure Docker Container
VOLUME ["/data"]
EXPOSE 3022 3000
USER git
ENV USER=git

ENTRYPOINT ["/opt/gogs/gogs"]
CMD [ "web", "--config=/data/app.ini" ]
