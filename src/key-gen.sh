#!/bin/sh

if [ -z "$1" ]
then
      echo "Not name of environment, project and script. Example usage $0 master server start"
      exit 1
fi

NAMESPACE=$1
PROJECT=$2
SCRIPT=$3

echo "start-node-process-on-$NAMESPACE-for-$PROJECT-with-npm-run-$SCRIPT"