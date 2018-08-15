#! /bin/bash

# delete old data
bash clear.sh

# run docker container
docker-compose up -d

# create table
ls | grep clickhouse | xargs -I% bash ./cmd/create.sh %

# insert data
bash ./cmd/insert.sh

