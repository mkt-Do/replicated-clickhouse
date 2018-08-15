FROM ubuntu:xenial

RUN set -x && \
    apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y apt-transport-https && \
    apt-get install -y software-properties-common && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv E0C56BD4 && \
    apt-add-repository "deb http://repo.yandex.ru/clickhouse/xenial stable main" && \
    apt-get update && \
    apt-get install clickhouse-server-common clickhouse-client -y

VOLUME /var/lib/clickhouse

CMD ["clickhouse-server", "--config-file=/etc/clickhouse-server/config.xml"]

