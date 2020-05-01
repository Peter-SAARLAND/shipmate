#! /bin/bash
set -e

if [ -f Shipfile ];
then
  set -o allexport
  source Shipfile
  set +o allexport
fi
exec "$@"