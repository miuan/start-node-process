#!/bin/sh

if [ -z "$1" ]
then
    echo "This script $0 have to be call with 'snp update'"
    exit
fi

SNP_SCRIPT_DIR=$1
SCRIPT=$2
PROJECT=$3
NAMESPACE=$4

sh $SNP_SCRIPT_DIR/stop.sh $SNP_SCRIPT_DIR $NAMESPACE $PROJECT $SCRIPT 

git pull
# git checkout "$NAMESPACE"
rm -rf node_modules 
# yarn install --frozen-lockfile
npm ci

echo "snp start $SCRIPT $PROJECT $NAMESPACE"
sh $SNP_SCRIPT_DIR/start.sh $SNP_SCRIPT_DIR $SCRIPT $PROJECT $NAMESPACE