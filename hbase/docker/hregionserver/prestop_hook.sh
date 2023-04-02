#!/bin/bash
current_server=$(curl -s "0:16030/rs-status" | grep "HBase Region Server" | grep -o -E "([0-9]+\.)+[0-9]+")
graceful_stop.sh $current_server
killall5