#!/bin/sh

if [ -z "$1" ]
then
      echo "Not name of environment, project and script. Example usage $0 master server start"
      exit 1
fi

NAMESPACE=$1
PROJECT=$2
SCRIPT=$3

KEY="start-node-process-on-$NAMESPACE"

if [ ! -z "$PROJECT" ]
then
      KEY="$KEY-for-$PROJECT"
fi

if [ ! -z "$SCRIPT" ]
then
      KEY="$KEY-with-npm-run-$SCRIPT"
fi

echo $KEY