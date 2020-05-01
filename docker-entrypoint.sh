#! /bin/bash
set -e

SHIPFILE=$SHIPMATE_CARGO_DIR/$SHIPMATE_SHIPFILE

if [ -f $SHIPFILE ];
then
  set -o allexport
  source $SHIPFILE
  set +o allexport
fi
exec "$@"