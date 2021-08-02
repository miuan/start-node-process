#!/bin/bash

if [ -z "$1" ]
then
      echo "Action not provided, known actions: update, key-gen, kill, start, state, restart, tail, tailf"
      echo ""
      echo "      update - kill process, update git source base and reinstall packages, start process again"
      echo ""
      echo "            snp update [script] [project-name] [namespace]"
      echo ""
      echo "            snp update"
      echo "            snp update start:prod server"
      echo "            snp update start:prod server graphqlmonster"
      echo "            snp kill prod"
      echo "            snp key-gen prod"
      echo ""
      echo ""
      echo "      key-gen - generate uniq key base on parameters"
      echo ""
      echo "            snp key-gen [namespace] [project-name] [script]"
      echo ""
      echo "            snp key-gen"
      echo "            snp key-gen graphqlmonster"
      echo "            snp key-gen graphqlmonster server start:prod"
      echo ""
      echo ""
      echo "      restart - restart process without update"
      echo ""
      echo "            snp restart [script] [project-name] [namespace]"
      echo ""
      echo "            snp restart"
      echo "            snp restart start:prod"
      echo "            snp restart start:prod server graphqlmonster"
      echo ""
      echo ""
      echo "      start - start npm script in background"
      echo ""
      echo "            snp start [script] [project-name] [namespace]"
      echo ""
      echo "            snp start"
      echo "            snp start start:prod"
      echo "            snp start start:prod server graphqlmonster"
      echo ""
      echo "            default [script] is 'start' so finall command will be 'npm start'"
      echo "            default [project-name] is current cwd directory"
      echo "            default [namespace] is current user name"
      echo ""
      echo ""
      echo "      state - show list of runned process "
      echo ""
      echo "            snp state [namespace] [project-name] [script]"
      echo ""
      echo "            snp state"
      echo "            snp state graphqlmonster"
      echo "            snp state graphqlmonster server start:prod"
      echo ""
      echo "            default [script] is 'start' so finall command will be 'npm start'"
      echo "            default [project-name] is current cwd directory"
      echo "            default [namespace] is current user name"
      echo ""
      echo ""
      echo "      stop - stop running process and wait is end"
      echo ""
      echo "            snp stop [namespace] [project-name] [script]"
      echo ""
      echo "            snp stop"
      echo "            snp stop graphqlmonster"
      echo "            snp stop graphqlmonster server start:prod"
      echo ""
      echo ""
      echo "      tail - tail created log"
      echo ""
      echo "            snp tail [script] [project-name] [namespace]"
      echo ""
      echo "            snp tail"
      echo "            snp tail start:prod"
      echo "            snp tail start:prod server graphqlmonster"
      echo ""
      echo ""
      echo "      tailf - tail created log with listen"
      echo ""
      echo "            snp tail [script] [project-name] [namespace]"
      echo ""
      echo "            snp tail"
      echo "            snp tail start:prod"
      echo "            snp tail start:prod server graphqlmonster"
      exit 1
fi

SCRIPT=$2
PROJECT=$3
NAMESPACE=$4

# state and stop have oposite order
SCRIPT_STATE=$4
PROJECT_STATE=$3
NAMESPACE_STATE=$2

# scritp name for default is `start`
if [ -z "$4" ] 
then
      NAMESPACE="$(eval id -un)"
fi

if [ -z "$3" ] 
then
      PROJECT="$(eval basename '$PWD')"
fi

# anything is setup
if [ -z "$2" ] 
then
      SCRIPT="start"
      # just if anything setuped -> then setup state, stop, key-gen
      # because they can be optional (empty) to make bigger "range"
      # like show state for all run projects in namespace 
      # or even like stop evertihing in namespace or namespace and project and don't care about script
      NAMESPACE_STATE=$NAMESPACE
fi


# https://stackoverflow.com/questions/59895/how-can-i-get-the-source-directory-of-a-bash-script-from-within-the-script-itsel
# SNP_SCRIPT_DIR="$(eval dirname '$0')"
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
SNP_SCRIPT_DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

case $1 in
        update)
        echo "UPDATE namespace:$NAMESPACE, project:$PROJECT, script:$SCRIPT"
        sh $SNP_SCRIPT_DIR/update.sh $SNP_SCRIPT_DIR $SCRIPT $PROJECT $NAMESPACE
        exit 0
        ;;
        key-gen)
        sh $SNP_SCRIPT_DIR/key-gen.sh $NAMESPACE_STATE $PROJECT_STATE $SCRIPT_STATE
        exit 0
        ;;
        start)
        echo "START namespace:$NAMESPACE, project:$PROJECT, script:$SCRIPT"
        sh $SNP_SCRIPT_DIR/start.sh $SNP_SCRIPT_DIR $SCRIPT $PROJECT $NAMESPACE
        exit 0
        ;;
        state)
        echo "STATE namespace:$NAMESPACE_STATE, project:[$PROJECT_STATE], script:[$SCRIPT_STATE]"
        sh $SNP_SCRIPT_DIR/state.sh $SNP_SCRIPT_DIR $NAMESPACE_STATE $PROJECT_STATE $SCRIPT_STATE
        exit 0
        ;;
        stop)
        echo "STOP namespace:$NAMESPACE_STATE, project:[$PROJECT_STATE], script:[$SCRIPT_STATE]"
        sh $SNP_SCRIPT_DIR/stop.sh $SNP_SCRIPT_DIR $NAMESPACE_STATE $PROJECT_STATE $SCRIPT_STATE
        exit 0
        ;;
        restart)
        echo "RESTART namespace:$NAMESPACE, project:$PROJECT, script:$SCRIPT"
        sh $SNP_SCRIPT_DIR/stop.sh $SNP_SCRIPT_DIR $NAMESPACE $PROJECT $SCRIPT
        sh $SNP_SCRIPT_DIR/start.sh $SNP_SCRIPT_DIR $SCRIPT $PROJECT $NAMESPACE
        exit 0
        ;;
        tail)
        echo "TAIL namespace:$NAMESPACE, project:$PROJECT, script:$SCRIPT"
        sh $SNP_SCRIPT_DIR/tail.sh $SNP_SCRIPT_DIR $SCRIPT $PROJECT $NAMESPACE
        exit 0
        ;;
        tailf)
        echo "TAILF namespace:$NAMESPACE, project:$PROJECT, script:$SCRIPT"
        sh $SNP_SCRIPT_DIR/tail.sh $SNP_SCRIPT_DIR $SCRIPT $PROJECT $NAMESPACE -f
        exit 0
        ;;
esac

echo "Unknown action: '$1' known actions: update, key-gen, kill, start, state, restart, tail, tailf"