# Dockerizing a base images with:
#
#   - Alpine 3.17
#   - OpenJDK 17
#
# Build:    docker build -t vinhio/jdk:17-alpine .
# Run:      docker run -ti vinhio/jdk:17-alpine java -version
# Run:      docker run -ti -u java vinhio/jdk:17-alpine bash

FROM alpine:3.17

WORKDIR /home/java
VOLUME /home/java
EXPOSE 80 443

# Labels.
LABEL com.jivecode.schema-version="1.0" \
    com.jivecode.build-date=$BUILD_DATE \
    com.jivecode.name="vinhio/jdk:17-alpine" \
    com.jivecode.description="Docker JDK 17" \
    com.jivecode.url="http://www.jivecode.com" \
    com.jivecode.vcs-url="https://github.com/vinhio/docker-jdk" \
    com.jivecode.vcs-ref=$VCS_REF \
    com.jivecode.vendor="JiveCode" \
    com.jivecode.version=$BUILD_VERSION \
    com.jivecode.docker.cmd="docker run -ti -u java jdk:17-alpine bash"

# Replace default `java` user and group with IDs, matching current host user (developer)
ARG hostUID=1000
ARG hostGID=1000
ENV hostUID=$hostUID
ENV hostGID=$hostGID
RUN addgroup -g $hostGID java && \
    adduser -S -u $hostUID -G java -h /home/java -s /sbin/nologin java && \
    chown -v $hostUID:$hostGID /var

# Install JDK and package
RUN  apk update \
  && apk upgrade \
  && apk add ca-certificates \
  && update-ca-certificates \
  && apk add --update coreutils && rm -rf /var/cache/apk/* \
  && apk add --update openjdk17 tzdata curl unzip bash \
  && apk add --no-cache nss \
  && rm -rf /var/cache/apk/*

### Copy configuration files
ADD rootfs /
