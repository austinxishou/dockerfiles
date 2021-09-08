FROM alpine:3.9
LABEL authors="austindev@163.com"
LABEL description="用于定时备份mysql数据"

# 更新为国内的镜像
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories


RUN apk add --update \
    'mariadb-client>10.3.15' mariadb-connector-c \
    tzdata bash gzip openssl && \
    rm -rf /var/cache/apk/* && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime 

# install the entrypoint
COPY functions.sh /
COPY entrypoint /entrypoint

# copy ossutil64
COPY ossutil64 /usr/local/bin/

# start
ENTRYPOINT ["/entrypoint"]
