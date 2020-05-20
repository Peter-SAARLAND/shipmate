#! /bin/bash
set -e

SHIPMATE_CARGO_DIR=${SHIPMATE_CARGO_DIR:-/cargo}
SHIPMATE_SHIPFILE=${SHIPMATE_SHIPFILE:-shipmate.env}
SHIPFILE=$SHIPMATE_CARGO_DIR/$SHIPMATE_SHIPFILE

if [ -d $ENVIRONMENT_DIR ];
then
  # ToDo: replace this with `if0 environment load`
  set -o allexport
  export $(grep -hv '^#' $ENVIRONMENT_DIR/*.env | xargs) > /dev/null 2>&1
  set +o allexport
fi

if [ -f $SHIPFILE ];
then
  set -o allexport
  source $SHIPFILE
  set +o allexport
fi
exec "$@"