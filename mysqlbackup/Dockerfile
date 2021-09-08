FROM alpine:3.9
LABEL authors="austindev@163.com"
LABEL description="用于定时备份mysql数据"

# 更新为国内的镜像
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories


RUN apk add --update \
    'mariadb-client>10.3.15' mariadb-connector-c \
    tzdata bash gzip openssl && \
    samba-client shadow && \
    touch /etc/samba/smb.conf && \
    rm -rf /var/cache/apk/* && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime 

# set us up to run as non-root user
RUN groupadd -g 1005 appuser && \
    useradd -r -u 1005 -g appuser appuser
# ensure smb stuff works correctly
RUN mkdir -p /var/cache/samba && chmod 0755 /var/cache/samba && chown appuser /var/cache/samba
USER appuser

# install the entrypoint
COPY functions.sh /
COPY entrypoint /entrypoint

# start
ENTRYPOINT ["/entrypoint"]
