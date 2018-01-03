FROM ubuntu:rolling

COPY rootfs /

ARG DOWNLOAD_URL

RUN \

    export DEBIAN_FRONTEND=noninteractive && \

    # Update apt-cache
    apt-get update && \

    # Install tzdata
    apt-get install -y --no-install-recommends \
        tzdata && \

    # Install SSL
    apt-get install -y --no-install-recommends \
        ca-certificates \
        openssl && \

    # Install curl
    apt-get install -y --no-install-recommends \
        curl && \

    # Install gosu
    apt-get install -y --no-install-recommends \
        gosu && \

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

    # Install temporary-tools
    apt-get install -y --no-install-recommends \
        unzip && \

    # Install Java
    apt-get install -y --no-install-recommends \
        default-jre-headless && \

    # Install unifi
    curl -SL $DOWNLOAD_URL -o /tmp/unifi.zip && \
    unzip /tmp/unifi.zip -d /tmp/ && \
    mv /tmp/UniFi /usr/lib/unifi && \
    chown -R unifi:unifi /usr/lib/unifi && \

    # Remove unnecessary files
    rm -rf \
        /usr/lib/unifi/bin \
        /usr/lib/unifi/lib/native/Linux/armhf \
        /usr/lib/unifi/lib/native/Mac \
        /usr/lib/unifi/lib/native/Windows \
        /usr/lib/unifi/readme.txt && \

    # Remove temporary-tools
    apt-get purge -y \
        unzip && \

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

VOLUME /usr/lib/unifi/data

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
