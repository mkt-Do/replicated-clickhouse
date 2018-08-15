#! /bin/bash

SCRIPT_DIR=`dirname $0`
cd $SCRIPT_DIR

cat ../sql/insert.sql | xargs -I% docker exec clickhouse-master clickhouse-client --query=%

