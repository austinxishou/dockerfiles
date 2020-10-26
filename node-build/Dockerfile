FROM node:12.18.4-alpine3.9
RUN apk --update --no-cache add git openssh-client curl gettext
COPY docker-entrypoint.sh /usr/local/bin/
COPY git-init.sh /usr/local/bin/
COPY oss-init.sh /usr/local/bin/
COPY npm-login-cmd.js /usr/local/bin/
COPY ossutil64 /usr/local/bin/
COPY kubectl /usr/local/bin/
COPY cluster-info.yaml /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]