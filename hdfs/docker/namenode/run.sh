#!/bin/bash

namedir=`echo $HDFS_CONF_dfs_namenode_name_dir | perl -pe 's#file://##'`
if [ ! -d $namedir ]; then
  echo "Namenode name directory not found: $namedir"
  exit -1
fi

if [ -z "$CLUSTER_NAME" ]; then
  echo "Cluster name not specified"
  exit -1
fi

if [[ `hostname -s` =~ (.*)-([0-9]+)$ ]]; then
    NAME=${BASH_REMATCH[1]}
    HOSTNAME_IDX=${BASH_REMATCH[2]}
else
    echo "Failed to parse name and ordinal of pod"
    exit -1
fi

if [ $HOSTNAME_IDX -eq 0 ]; then
  if [ "`ls -A $namedir`" == "" ]; then
    echo "Formatting namenode name directory: $namedir"
    set -e
    $HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR namenode -format -clusterid $CLUSTER_NAME -force
    set +e

    echo "Formatting zkfc"
    OUTPUT=$($HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR zkfc -formatZK -force 2>&1)
    echo $OUTPUT
    (echo $OUTPUT | grep -q "FATAL") && exit -1
  fi
else
  if [ "`ls -A $namedir`" == "" ]; then
    echo "Starting namenode for standby"
    $HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR namenode -bootstrapStandby -nonInteractive
  fi
fi

echo "Starting zkfc daemon"
$HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR --daemon start zkfc
echo "Starting namenode"
$HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR namenode