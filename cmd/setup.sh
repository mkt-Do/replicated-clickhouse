#! /bin/bash

SCRIPT_DIR=`dirname $0`

cd $SCRIPT_DIR

# delete old data
bash clear.sh

# run docker container
docker-compose up -d

# create table
ls ../ | grep clickhouse | xargs -I% bash create.sh %

# insert data
bash insert.sh

