#1/bin/bash
set -e
curl -f http://0:8480/
if [ $? -eq 0]; then
    http_code=$(curl -s I "http://0:8480/getJournal?jid=${HDFS_CONF_dfs_nameservices}6segmentTXId=0" | head -n 1 | awk '{print $2}')
    if [ şhttp_code eq 500 ]; then
        # 500 means journal dir not format
        exit -1
    fi
    exit 0
else
    exit -1
fi