#! /bin/bash
set -e

if [ -f /ship/Shipfile ];
then
  set -o allexport
  source Shipfile
  set +o allexport
fi
exec "$@"