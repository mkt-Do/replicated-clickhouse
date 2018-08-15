CREATE DATABASE test;

CREATE TABLE test.tests( date Date, id UInt64, foo UInt64 ) ENGINE = ReplicatedSummingMergeTree( \'/clickhouse/tables/shard-{shard}/tests\', \'{replica}\', date, id, 8192, foo );

CREATE TABLE test.dist_tests ( date Date, id UInt64, foo UInt64 ) ENGINE = Distributed( cluster_01, test, tests, id );

