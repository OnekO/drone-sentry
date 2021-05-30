#!/bin/bash

export SENTRY_AUTH_TOKEN=${PLUGIN_AUTH_TOKEN}
export SENTRY_ORG=${PLUGIN_ORG}
export SENTRY_PROJECT=${PLUGIN_PROJECT}
export SENTRY_RELEASE=${PLUGIN_RELEASE}
export SENTRY_ENVIRONMENT=${PLUGIN_ENVIRONMENT}
export SENTRY_RELEASE=${PLUGIN_VERSION}

git clone ${DRONE_GIT_HTTP_URL} && cd ${DRONE_REPO_NAME}
git checkout ${DRONE_SOURCE_BRANCH}
echo "Creando release ${SENTRY_RELEASE}"
sentry-cli releases new -p $SENTRY_PROJECT $SENTRY_RELEASE
echo "Commits para ${SENTRY_RELEASE}"
sentry-cli releases set-commits $SENTRY_RELEASE --auto
echo "Sourcemaps para ${SENTRY_RELEASE}"
sentry-cli releases files $SENTRY_RELEASE upload-sourcemaps src
echo "Finalizando release ${SENTRY_RELEASE}"
sentry-cli releases finalize $SENTRY_RELEASE
echo "Release ${SENTRY_RELEASE} desplegada  "
sentry-cli releases deploys $SENTRY_RELEASE new -e $SENTRY_ENVIRONMENT
