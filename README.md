# ClickHouse Replicated Server (With ZooKeeper)
## How To Use
First, run container orchestration.
```
bash cmd/setup.sh
```
This shell executes following processing.
* delete old data
* run containers (zookeeper x 1, clickhouse-server x 4)
* create tables
* insert data

When you use clickhouse-client, you can execute following command.
```
bash cmd/clickhouse-client.sh {servername}
```
Original servers are
* clickhouse-master
* clickhouse-master-shard
* clickhouse-replica
* clickhouse-replica-shard
If you want to add server, you create directory with servername.

## Customization
If you add zookeeper containers, you write docker-compose.yml and clickhouse-X/config.xml.  
### docker-compose.yml
```docker-compose.yml
...
  zookeeper-2:
    container_name: "zookeeper-2"
    image: "zookeeper"
    restart: always
    ports:
      - 2182:2181
      - 2889:2888
      - 3889:3888
    volumes:
      - "./zookeeper-2/volumes/data:/data"
      - "./zookeeper-2/volumes/datalog:/datalog"
    hostname: "zookeeper-2"
    environment:
      ZOO_MY_ID: 2
      ZOO_SERVERS: "server.1=zookeeper-1:2888:3888 server.2=zookeeper-2:2888:3888" 
...
    depends_on:
      - "zookeeper-1"
      - "zookeeper-2"
...
```

## License
WTFPL

