#!/bin/bash
curl -s "http://localhost:16030/rs-status" | head -n 1 | grep -q "The RegionServer is initializing"
if [ $? -eq 0 ]; then
    # grep found matched text which means that "The RegionServer is initializing"
    exit -1
else
    exit 0
fi