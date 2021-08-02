#!/bin/sh

if [ -z "$4" ]
then
    echo "Script $0 have to be call over snp with parameter tail"
    exit
fi

SNP_SCRIPT_DIR=$1
SCRIPT=$2
PROJECT=$3
NAMESPACE=$4

KEY="$(eval sh $SNP_SCRIPT_DIR/key-gen.sh $NAMESPACE $PROJECT $SCRIPT)"

# fix problem with : for creting log files
PS="-"
LOGBASE=$(echo "/var/log/$NAMESPACE/$PROJECT-$SCRIPT" | sed "s/:/$PS/")
LOGFILE="$LOGBASE.log"
LOGERROR="$LOGBASE.error.log"

if [ "$5" = "-f" ]
then
    echo "tail -f $LOGFILE -n 1000"
    tail -f $LOGFILE -n 1000
else 
    echo "tail $LOGFILE -n 1000"
    tail $LOGFILE -n 1000
fi