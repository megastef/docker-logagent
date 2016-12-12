#!/bin/bash

if [ "$LOG_INDEX" == "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" ]; then
  echo "You need to set the LOG_INDEX in the environment!" >&2
  exit 1
fi

if [ "$LOG_GLOB" == "" ]; then
  echo "You need to set the LOG_GLOB in the environment!" >&2
  exit 1
fi

echo "Preparing environment..."

touch /etc/sematext/logagent.conf
chmod 600 /etc/sematext/logagent.conf

cat > /etc/sematext/logagent.conf <<EOF
# Global options
options:
  printStats: 60
  suppress: true
  geoipEnabled: true
  diskBufferDir: /tmp/sematext-logagent

input:
  files:
EOF

while IFS=';' read -ra ADDR; do
  for i in "${ADDR[@]}"; do
    echo "    - ${i}" >> /etc/sematext/logagent.conf
  done
done <<< "$LOG_GLOB"

cat >> /etc/sematext/logagent.conf <<EOF
output:
  # index logs in Elasticsearch or Logsene
  elasticsearch:
    url: ${LOG_URL}
    index: ${LOG_INDEX}
EOF

exec /usr/local/bin/logagent -c /etc/sematext/logagent.conf
