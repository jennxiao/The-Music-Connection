#!/bin/bash
# Hack fix for Rails-specific bug with Docker
set -e

rm -f /The-Music-Connection/tmp/pids/server.pid

exec "$@"
