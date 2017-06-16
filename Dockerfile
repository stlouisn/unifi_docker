FROM ubuntu:rolling

ARG UNIFI_VERSION=5.5.17-4f48295a02

RUN \

#  # Create ubnt group
#  addgroup -S \
#      -g 99 \
#      ubnt && \

#  # Create ubnt user
#  adduser -S -D -H \
#      -s /sbin/nologin \
#      -G ubnt \
#      -g ubnt \
#      -u 99 \
#      ubnt && \

  # Update apt-cache
  apt update && \

  # Install gosu
  DEBIAN_FRONTEND=noninteractive \
    apt install -y \
    --no-install-recommends \
      gosu && \

  # Install SSL
  DEBIAN_FRONTEND=noninteractive \
    apt install -y \
    --no-install-recommends \
      ca-certificates \
      openssl && \

  # Install Java
  DEBIAN_FRONTEND=noninteractive \
    apt install -y \
    --no-install-recommends \
      default-jre-headless && \

  # Install build-tools
  DEBIAN_FRONTEND=noninteractive \
    apt install -y \
    --no-install-recommends \
      unzip \
      wget && \
      
  # Install unifi
  wget \
      https://www.ubnt.com/downloads/unifi/${UNIFI_VERSION}/UniFi.unix.zip \
      -O /tmp/unifi.zip && \
  unzip \
      /tmp/unifi.zip \
      -d /tmp/ && \
  mv /tmp/UniFi /usr/lib/unifi && \

  # Remove unnecessary files
  rm -rf \
    /usr/lib/unifi/bin \
    /usr/lib/unifi/lib/native/Linux/armhf \
    /usr/lib/unifi/lib/native/Mac \
    /usr/lib/unifi/lib/native/Windows && \

# execstack

  # Remove build-tools
  DEBIAN_FRONTEND=noninteractive \
    apt purge -y \
      unzip \
      wget && \

  # Clean apt-cache
  apt autoremove -y --purge && \
  apt autoclean -y && \

  # Cleanup temporary folders
  rm -rf \
      /tmp/* \
      /var/lib/apt/lists/* && \

COPY rootfs /

RUN chmod 0744 /usr/local/bin/docker_entrypoint.sh

ENV JAVA_HOME /usr/lib/jvm/default-java/jre

VOLUME /usr/lib/unifi/data

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]