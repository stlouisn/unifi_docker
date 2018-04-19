FROM stlouisn/java:default

COPY rootfs /

RUN \

    export DEBIAN_FRONTEND=noninteractive && \

    # Create unifi group
    groupadd \
        --system \
        --gid 9999 \
        unifi && \

    # Create unifi user
    useradd \
        --system \
        --no-create-home \
        --shell /sbin/nologin \
        --comment unifi \
        --gid 9999 \
        --uid 9999 \
        unifi

COPY --chown=unifi:unifi userfs /

VOLUME /usr/lib/unifi/data

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
