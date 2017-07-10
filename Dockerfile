FROM ubuntu:rolling

COPY docker.rootfs /

RUN \

    export UNIFI_VERSION=5.5.19 && \

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

    # Install Java
    apt install -y --no-install-recommends \
        default-jre-headless && \

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
        unzip \
        wget && \
      
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
    
EXPOSE 8080 \
       8443 \
       8843 \
       8880

VOLUME /usr/lib/unifi/data

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
