FROM 192.168.9.128:5000/jayeljj/hadoop-base:3.3.4

ENV HDFS_CONF_dfs_journalnode_edits_dir=/hadoop/dfs/journal
ADD run.sh /run.sh
ADD health.sh /health.sh

# set log root logger config, hadoop start command use this env to override config in log4j-properties
ENV HADOOP_ROOT_LOGGER=-"INFO,console,RFA"

CMD ["/run.sh"]