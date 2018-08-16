# ClickHouse Replicated Server (With ZooKeeper)
## How To Use
First, run container orchestration.
```bash
$ bash cmd/setup.sh
```
This shell(setup.sh) executes following processing.
* delete old data
* run containers (zookeeper x 1, clickhouse-server x 4)
* create test tables
* insert test data
If you don't want to create test tables and insert test data, you can use following command.
```bash
$ docker-compose up -d
```
When you execute this command, you can use no record clickhouse-server.  

When you use clickhouse-client, you can execute following command.
```bash
$ bash cmd/clickhouse-client.sh {servername} [option]
or
$ docker exec -it {servername} clickhouse-client [option]
```
Original servernames are
* clickhouse-master
* clickhouse-master-shard
* clickhouse-replica
* clickhouse-replica-shard
If you want to add server, you create directory with new servername and write docker-compose.yml.

## Customization
If you add zookeeper containers, you edit `docker-compose.yml` and `{servername}/conf.d/zookeeper.xml`.
### docker-compose.yml
```yml
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
#### {servername}/conf.d/zookeeper.xml
```xml
<yandex>
  <zookeeper>
    <node index="1">
      <host>zookeeper</host>
      <port>2181</port>
    </node>
    <!-- add following node tag -->
    <node>
      <host>zookeeper-2</host>
      <port>2181</port>
    </node>
  </zookeeper>
</yandex>
```
When you add clickhouse containers, first you create directory and then you edit `docker-compose.yml` and some files in `{servername}/conf.d/`.
```bash
$ cp -r clickhouse-template clickhouse-yours
```
And edit each files.
#### docker-compose.yml
```yml
  clickhouse-yours:
    container_name: "clickhouse-yours"
    build:
      context: .
      dockerfile: "./common/Dockerfile"
    depends_on:
      - zookeeper
    restart: always
    ports:
      - 8127:8123
      - 9004:9000
    volumes:
      - "./common/config.xml:/etc/clickhouse-server/config.xml"
      - "./clickhouse-yours/conf.d:/etc/clickhouse-server/conf.d"
      - "./clickhouse-yours/volumes:/var/lib/clickhouse"
    hostname: "clickhouse-yours"
```
#### clickhouse-yours/conf.d/macros.xml
```xml
<yandex>
  <macros>
    <shard>1</shard> <!-- if this server is shard server, you set shard number. -->
    <replica>clickhouse-yours</replica> <!-- edit your server name -->
  </macros>
</yandex>
```
#### clickhouse-yours/conf.d/cluster.xml
```xml
<yandex>
  <remote_servers>
    <cluster_01>
      <shard>
        <!-- Optional. Shard weight when writing data. Defalut: 1. -->
        <weight>1</weight> <!-- setting weight if you shard this server -->
        <internal_replication>true</internal_replication>
        <replica>
          <host>clickhouse-master</host> <!-- edit your clickhouse server -->
          <port>9000</port>
          <user>default</user>
          <password></password>
        </replica>
      </shard>
      <shard>
        <weight>1</weight> <!-- if you use shard, set this parameter. -->
        <internal_replication>true</internal_replication>
        <replica>
          <host>clickhouse-master-shard</host> <!-- your sharding server -->
          <port>9000</port>
          <user>default</user>
          <password></password>
        </replica>
      </shard>
    </cluster_01>
  </remote_servers>
</yandex>
```

## License
WTFPL

