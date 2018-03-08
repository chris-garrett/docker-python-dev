#!/bin/bash
set -e

if [ -f /work/app/.env/bin/activate ]; then
    echo "Virtual environment exists at /work/app/.env, activating..."
    . /work/app/.env/bin/activate
else
    echo "Virtual environment missing from /work/app/.env, initializing..."
    /usr/local/bin/initenv
    . /work/app/.env/bin/activate
fi

exec "$@"
