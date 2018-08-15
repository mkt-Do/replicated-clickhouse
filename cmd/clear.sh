#!/bin/bash

SCRIPT_DIR=`dirname $0`
cd $SCRIPT_DIR

rm -rf ../clickhouse-master/volumes/* ../clickhouse-master-shard/volumes/* ../clickhouse-replica/volumes/* ../clickhouse-replica-shard/volumes/* ../zookeeper/volumes/data/* ../zookeeper/volumes/datalog/*

