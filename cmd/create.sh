#! /bin/sh

SCRIPT_DIR=`dirname $0`
cd $SCRIPT_DIR

SERVER=$1
cat ../sql/create.sql | xargs -I% docker exec $SERVER clickhouse-client --query=%

