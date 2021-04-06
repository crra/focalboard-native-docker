ARG GOLANG_BUILDER_IMAGE=golang:buster
ARG DIST_IMAGE=gcr.io/distroless/static

FROM ${GOLANG_BUILDER_IMAGE} as builder

ARG focalboard_version
ENV FOCALBOARD_VERSION=${focalboard_version}

WORKDIR /usr/src

RUN curl -L -o focalboard-bin.tgz https://github.com/mattermost/focalboard/releases/download/v${FOCALBOARD_VERSION}/focalboard-server-linux-amd64.tar.gz && \
    mkdir focalboard && \
    tar xzf focalboard-bin.tgz -C focalboard --strip-components=1

RUN curl -L -o focalboard-src.tgz "https://github.com/mattermost/focalboard/archive/refs/tags/v${FOCALBOARD_VERSION}.tar.gz" && \
    mkdir source && \
    tar xzf focalboard-src.tgz -C source --strip-components=1

RUN cd source && BUILD_NUMBER="${FOCALBOARD_VERSION}" LDFLAGS='-w -s -extldflags "-static"' make server
RUN cp source/bin/focalboard-server focalboard/bin

FROM ${DIST_IMAGE}

EXPOSE 8000

WORKDIR /opt/focalboard
COPY --from=builder /usr/src/focalboard .

ENTRYPOINT ["/opt/focalboard/bin/focalboard-server"]