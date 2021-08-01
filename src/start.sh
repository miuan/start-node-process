#!/bin/sh

if [ -z "$1" ]
then
    echo "Script $0 have to be call with 'snp start' command"
    exit
fi

SNP_SCRIPT_DIR=$1
SCRIPT=$2
PROJECT=$3
NAMESPACE=$4

KEY="$(eval sh $SNP_SCRIPT_DIR/key-gen.sh $NAMESPACE $PROJECT $SCRIPT)"

if [ -z "$KEY" ]
then
      echo "The 'key-gen.sh' script not generated key properly."
      echo "May not exists, should be located in home ~/scripts/ directory"
      echo "or in ./scripts from current working directory"
      exit 1
fi

echo "Check if process already not started '$KEY'"

PS="ps aux | grep 'snp-key=$KEY' | grep -v grep | awk '{ print \$2 }' | grep -v PID | awk '\$1=\$1' ORS=' '"
RUN_PS="$(eval $PS)"
echo "$PS"

if [ ! -z "$RUN_PS" ]
then
      echo "Process is already running, in case of restart use 'snp restart'"
      exit 1
fi

# fix problem with : for creting log files
PS="-"
LOGBASE=$(echo "/var/log/$NAMESPACE/$PROJECT-$SCRIPT" | sed "s/:/$PS/")
LOGFILE="$LOGBASE.log"
LOGERROR="$LOGBASE.error.log"

# remove old logs
if test -f "$LOGFILE"; then
    echo "Remove old $LOGFILE"
    rm $LOGFILE
fi

if test -f "$LOGERROR"; then
    echo "Remove old $LOGERROR"
    rm $LOGERROR
fi

# whate ever run
echo "npm run $SCRIPT -- --snp-key=$KEY >> $LOGFILE 2>>&1"
(npm run $SCRIPT -- --snp-key=$KEY >> $LOGFILE 2>&1 &) || { exit 1; }