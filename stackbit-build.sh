#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://rob-stackbit.ngrok.io/project/5eba0c52821fa15f7cbaf05a/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://rob-stackbit.ngrok.io/pull/5eba0c52821fa15f7cbaf05a 
fi
curl -s -X POST https://rob-stackbit.ngrok.io/project/5eba0c52821fa15f7cbaf05a/webhook/build/ssgbuild > /dev/null
gatsby build
./inject-netlify-identity-widget.js public
curl -s -X POST https://rob-stackbit.ngrok.io/project/5eba0c52821fa15f7cbaf05a/webhook/build/publish > /dev/null
