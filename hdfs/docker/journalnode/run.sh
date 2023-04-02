#!/bin/bash

function path_fix() {
    echo $1 | sed 's#//#/#g'
}

VERSION_DIR=$(path_fix ${HDFS_CONF_dfs_journalnode_edits_dir}/${HDFS_CONF_dfs_nameservices}/current)
if [ -f /etc/hadoop/VERSION.backup ]; then
    if [ ! -d $VERSION_DIR ]; then
        echo "create version dir $VERSION_DIR"
        mkdir -p $VERSION_DIR
    fi
    cp /etc/hadoop/VERSION.backup $VERSION_DIR/VERSION
fi

$HADOOP_HOME/bin/hdfs --config $HADOOP_CONF_DIR journalnode