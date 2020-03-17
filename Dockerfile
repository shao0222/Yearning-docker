FROM alpine:latest

ARG yearning_version=2.1.9

LABEL maintainer="shao0222-2020/03/17"

EXPOSE 8000

RUN cd /tmp \
    &&  wget https://github.com/cookieY/Yearning/releases/download/v${yearning_version}/Yearning-${yearning_version}.linux-amd64.zip \
    && unzip Yearning-${yearning_version}.linux-amd64.zip \
    && cp Yearning-go/Yearning  /opt/Yearning \
    && cp -r Yearning-go/dist /opt/dist \
    && cp Yearning-go/conf.toml /opt/conf.toml \
    && mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 \
    && echo "http://mirrors.ustc.edu.cn/alpine/v3.3/main/" > /etc/apk/repositories \
    && apk add --no-cache tzdata \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" >> /etc/timezone \
    && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf \
    && rm -rf /tmp/*

WORKDIR /opt

ENTRYPOINT  ["/opt/Yearning"]

CMD ["-m", "-s"]
