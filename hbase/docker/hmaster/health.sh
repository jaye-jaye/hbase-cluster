#!/bin/bash
curl -f "http://localhost:16010"
if [ $? -eq 0 ]; then
    exit 0
else
    exit -1
fi