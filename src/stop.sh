#!/bin/sh

if [ "$1" = "--port" ]
then
      if [ -z "$2" ]
      then
            echo "Not port included. Example usage with port:"
            echo "                 $0 --port 3000"
            exit 1
      fi

      PORT="$2"
      # https://stackoverflow.com/questions/3855127/find-and-kill-process-locking-port-3000-on-mac
      PS="npx kill-port $PORT"
      RUN_PS="$(eval $PS)"

      echo "$PS"
      echo "$RUN_PS"

      exit 0
fi

if [ -z "$1" ]
then
    echo "Script $0 have to be call with 'snp kill' command"
    exit
fi

SNP_SCRIPT_DIR=$1
NAMESPACE=$2
PROJECT=$3
SCRIPT=$4

KEY="$(eval sh $SNP_SCRIPT_DIR/key-gen.sh $NAMESPACE $PROJECT $SCRIPT)"

echo "Starting search process with key '$KEY'"

PS="ps aux | grep 'snp-key=$KEY' | grep -v grep | awk '{ print \$2 }' | grep -v PID | awk '\$1=\$1' ORS=' '"
RUN_PS="$(eval $PS)"
echo "$PS"

if [ -z "$RUN_PS" ]
then
      echo "Not found any process to kill"
      exit 1
fi

KILL="kill -9 $RUN_PS"
echo "$KILL"
RUN_KILL="$($KILL)"

# Wait till end of the process
echo "while ps -p $RUN_PS; do sleep 1;done;"
while ps -p $RUN_PS; do sleep 1;done;