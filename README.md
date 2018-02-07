# clickhouse-server that can be preserved data
## How to Use
```
docker-compose up -d
bash clickhouse-client.sh
```

## when you wanna change preserved Dir
```
vim docker-compose.yml
```
```docker-compose.yml
storage:
  ...
  volumes:
    (your directory):/var/lib/clickhouse
```

