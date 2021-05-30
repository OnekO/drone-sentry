FROM getsentry/sentry-cli
RUN apk add git
ADD script.sh /bin/
RUN chmod +x /bin/script.sh
ENTRYPOINT /bin/script.sh
