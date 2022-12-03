FROM ghcr.io/sdr-enthusiasts/docker-baseimage:base

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN set -x && \
    TEMP_PACKAGES=() && \
    KEPT_PACKAGES=() && \
    TEMP_PACKAGES+=(bzip2) && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        "${KEPT_PACKAGES[@]}" \
        "${TEMP_PACKAGES[@]}" \
        && \
    useradd --home-dir /home/ais --uid 1000 --user-group --create-home --system ais && \
    curl \
        -o /tmp/full.tar.bz2 \
        https://www.aishub.net/downloads/dispatcher/packages/latest/full.tar.bz2 \
        && \
    curl \
        -o /tmp/full.tar.bz2.md5 \
        https://www.aishub.net/downloads/dispatcher/packages/latest/full.tar.bz2.md5 \
        && \
    pushd /tmp && \
    md5sum --check ./full.tar.bz2.md5 && \
    tar xvf ./full.tar.bz2 -C /home/ais
