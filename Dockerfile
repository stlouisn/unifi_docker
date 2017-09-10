FROM ubuntu:rolling

COPY docker.rootfs /

RUN \

    export DEBIAN_FRONTEND=noninteractive && \

    # Update apt-cache
    apt update && \

    # Install tzdata
    apt install -y --no-install-recommends \
        tzdata && \

    # Install SSL
    apt install -y --no-install-recommends \
        ca-certificates \
        openssl && \

    # Install curl
    apt install -y --no-install-recommends \
        curl && \

    # Install gosu
    apt install -y --no-install-recommends \
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
    apt install -y --no-install-recommends \
        unzip && \

    # Install Java
    apt install -y --no-install-recommends \
        default-jre-headless && \

    export UNIFI_VERSION=`cat /unifi_version` && \

    # Install unifi
    curl -SL https://dl.ubnt.com/unifi/${UNIFI_VERSION}/UniFi.unix.zip -o /tmp/unifi.zip && \
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
    apt purge -y \
        unzip && \

    # Set docker_entrypoint as executable
    chmod 0744 /usr/local/bin/docker_entrypoint.sh && \

    # Clean apt-cache
    apt autoremove -y --purge && \
    apt autoclean -y && \

    # Cleanup temporary folders
    rm -rf \
        /root/.cache \
        /root/.wget-hsts \
        /tmp/* \
        /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/default-java/jre
    
VOLUME /usr/lib/unifi/data

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
