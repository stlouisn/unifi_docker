FROM stlouisn/ubuntu:rolling

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
        unifi && \

    # Update apt-cache
    apt-get update && \

    # Install Java
    apt-get install -y --no-install-recommends \
        default-jre-headless && \

    # Clean apt-cache
    apt-get autoremove -y --purge && \
    apt-get autoclean -y && \

    # Cleanup temporary folders
    rm -rf \
        /root/.cache \
        /root/.wget-hsts \
        /tmp/* \
        /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/default-java/jre

COPY --chown=unifi:unifi userfs /

VOLUME /usr/lib/unifi/data

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
