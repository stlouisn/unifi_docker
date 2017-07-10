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

    # Install gosu
    apt install -y --no-install-recommends \
        gosu && \

    # Create unifi group
    groupadd \
        --system \
        --gid 80000 \
        unifi && \

    # Create unifi user
    useradd \
        --system \
        --no-create-home \
        --shell /sbin/nologin \
        --comment unifi \
        --gid 80000 \
        --uid 80000 \
        unifi && \

    # Install build-tools
    apt install -y --no-install-recommends \
        curl \
        unzip \
        wget && \

    # Install Java
    apt install -y --no-install-recommends \
        default-jre-headless && \

    export UNIFI_VERSION=`curl -sSL https://raw.githubusercontent.com/stlouisn/unifi_docker/master/docker.labels/version | bash` && \

    # Install unifi
    wget https://www.ubnt.com/downloads/unifi/${UNIFI_VERSION}/UniFi.unix.zip \
        -O /tmp/unifi.zip && \
    unzip /tmp/unifi.zip -d /tmp/ && \
    mv /tmp/UniFi /usr/lib/unifi && \
    chown -R unifi:unifi /usr/lib/unifi && \
    
    # Remove unnecessary files
    rm -rf \
        /usr/lib/unifi/bin \
        /usr/lib/unifi/lib/native/Linux/armhf \
        /usr/lib/unifi/lib/native/Mac \
        /usr/lib/unifi/lib/native/Windows && \

    # Remove build-tools
    apt purge -y \
        curl \
        unzip \
        wget && \

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

ENV JAVA_HOME=/usr/lib/jvm/default-java/jre \
    LC_ALL=C.UTF-8
    
VOLUME /usr/lib/unifi/data

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
