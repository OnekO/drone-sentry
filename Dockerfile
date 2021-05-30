FROM getsentry/sentry-cli
RUN apk add git
COPY script.sh /bin/
RUN chmod +x /bin/script.sh
RUN ls /bin/script.sh
ENTRYPOINT /bin/script.sh
