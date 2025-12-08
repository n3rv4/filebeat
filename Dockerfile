ARG TARGETARCH

FROM debian:stable-slim

ARG TARGETARCH

# Remap arch names used by Buildx to match Elastic tarball names
RUN if [ "$TARGETARCH" = "amd64" ]; then export ARCH="x86_64"; else export ARCH="$TARGETARCH"; fi \
    && apt-get update \
    && apt-get install -y --no-install-recommends curl tar ca-certificates \
    && update-ca-certificates \
    && curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-8.14.0-linux-${ARCH}.tar.gz \
    && tar xzf filebeat-8.14.0-linux-${ARCH}.tar.gz \
    && mv filebeat-8.14.0-linux-${ARCH}/filebeat /usr/local/bin/filebeat \
    && chmod +x /usr/local/bin/filebeat \
    && rm -rf filebeat-8.14.0-linux-${ARCH}* \
    && mkdir -p /etc/filebeat
