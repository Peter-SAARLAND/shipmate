#! /bin/bash
set -e

SHIPMATE_CARGO_DIR=${SHIPMATE_CARGO_DIR:-/cargo}
SHIPMATE_SHIPFILE=${SHIPMATE_SHIPFILE:-shipmate.env}
SHIPFILE=$SHIPMATE_CARGO_DIR/$SHIPMATE_SHIPFILE

# if [ -d $ENVIRONMENT_DIR ];
# then
#   set -o allexport
#   export $(grep -shv '^#' $ENVIRONMENT_DIR/*.env | xargs) &>/dev/null
#   set +o allexport
# fi

if [ -f $SHIPFILE ];
then
  set -o allexport
  source $SHIPFILE
  set +o allexport
fi
exec "$@"