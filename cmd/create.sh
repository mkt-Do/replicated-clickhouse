#! /bin/sh

SERVER=$1
cat sql/create.sql | xargs -I% docker exec $SERVER clickhouse-client --query=%

