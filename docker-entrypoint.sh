#!/bin/sh
sed -i "s|__OPENAI_API_KEY__|${OPENAI_API_KEY:-not-set}|g" /usr/share/nginx/html/index.html
# Delegate to the original nginx entrypoint
exec /docker-entrypoint.sh "$@"
