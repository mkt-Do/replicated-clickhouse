#! /bin/bash

cat sql/insert.sql | xargs -I% docker exec clickhouse-master clickhouse-client --query=%

