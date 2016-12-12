FROM node:6-alpine
MAINTAINER Simon Erhardt <me+docker@rootlogin.ch>

ENV LOG_URL="https://logsene-receiver.sematext.com" \
  LOG_INDEX="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" \
  LOG_GLOB=""

RUN apk add --update \
  bash \
  tini \
  && rm -rf /var/cache/apk/*

# Install sematext logagent
RUN npm install -g @sematext/logagent

COPY bin/run.sh /opt/logagent/run.sh
RUN chmod +x /opt/logagent/run.sh

# Cleanup temp
RUN rm -rf /tmp/*

# Create directory for the logagent
RUN mkdir -p /etc/sematext

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/opt/logagent/run.sh"]
