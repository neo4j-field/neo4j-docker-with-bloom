#!/bin/sh
BLOOM_DIR="secrets"
if [ ! -d "./${BLOOM_DIR}" ]; then
	echo "Can't find local secrets directory. Please create one called ${BLOOM_DIR}"
	exit 1
fi

BLOOM_LICENSE_FILE="bloom-server.license"
if [ ! -f "${BLOOM_DIR}/${BLOOM_LICENSE_FILE}" ]; then
	echo "Can't find bloom license ${BLOOM_LICENSE_FILE} in secrets directory!"
	exit 1
fi

docker build -t neo4j-bloom:4.2-enterprise .

docker run --rm -it \
	-e NEO4J_AUTH=neo4j/password \
	-e NEO4J_ACCEPT_LICENSE_AGREEMENT=yes \
	-e NEO4JLABS_PLUGINS='["apoc"]' \
	-e NEO4J_neo4j_bloom_license__file="/secrets/${BLOOM_LICENSE_FILE}" \
	--mount="type=bind,src=$(realpath ${BLOOM_DIR}),dst=/secrets,readonly" \
	-p 7687:7687 \
	-p 7474:7474 \
	neo4j-bloom:4.2-enterprise

