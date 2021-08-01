#!/bin/sh

if [ -z "$1" ]
then
    echo "Script $0 have to be call with 'snp state' command"
    exit
fi

SNP_SCRIPT_DIR=$1
NAMESPACE=$2
PROJECT=$3
SCRIPT=$4


KEY="$(eval sh $SNP_SCRIPT_DIR/key-gen.sh $NAMESPACE $PROJECT $SCRIPT)"

echo "Starting search process with key '$KEY'"

PS="ps aux | grep '$KEY' | grep -v grep"
RUN_PS="$(eval $PS)"
echo "$PS"

if [ -z "$RUN_PS" ]
then
      echo "Not found any process try 'snp start' first"
      exit 1
fi

echo "$RUN_PS"