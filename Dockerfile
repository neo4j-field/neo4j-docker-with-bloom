## Download and unpack Bloom in another image
FROM alpine:latest AS bloom-downloader
ARG BLOOM_VERSION=1.4.1
RUN wget "https://s3.eu-west-2.amazonaws.com/bloom-releases/neo4j-bloom-${BLOOM_VERSION}.zip" -O /tmp/bloom.zip
RUN unzip /tmp/bloom.zip -d /tmp

## Build new Neo4j image derived from the stock image
FROM neo4j:4.2-enterprise
COPY --from=bloom-downloader --chown=7474:7474 /tmp/bloom-plugin-4.x-* /plugins/bloom-plugin.jar
VOLUME /secrets
USER 7474:7474
# set the bare-minimum config for Bloom to work
ENV NEO4J_dbms_security_procedures_unrestricted=bloom.* \
    NEO4J_dbms_unmanaged__extension__classes=com.neo4j.bloom.server=/bloom \
    NEO4J_dbms_security_http__auth__whitelist=/,/browser.*,/bloom.*
# operator will need to set the licese file setting and copy or mount into image at runtime
