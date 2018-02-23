# ClickHouse Replicated Server (With ZooKeeper)
## How To Use
```
docker-compose up -d
```
After containers are started, you execute the following command.
```
bash clickhouse-client.sh {clickhouse hostname} {option}
```
{clickhouse hostname} is clickhouse hostname such as `clickhouse-1`. (written `docker-compose.yml`)  
You can use {option} `--multiline`.
### clear.sh
This script is clear zookeeper data and clickhouse data.
```
bash clear.sh
```

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
### clickhouse-X/config.xml
```clickhouse-X/config.xml
...
    <zookeeper>
      <node index="1">
        <host>zookeeper-1</host>
        <port>2181</port>
      </node>
      <node index="2">
        <host>zookeeper-2</host>
        <port>2182</port>
      </node>
    </zookeeper>
...
```
