#!/bin/bash

server=$1
option=$2

docker exec -it $server clickhouse-client $option
