FROM ubuntu:latest
MAINTAINER Sean Feng<fengxiang220@gmail.com>

WORKDIR /root

ENV TZ=Asia/Shanghai
ENV PHDDNS_VERSION=5.2.0
ENV PACKAGE_NAME="phddns_${PHDDNS_VERSION}_amd64.deb"

RUN set -ex \
    && DEBIAN_FRONTEND="noninteractive" \
    && apt-get update \
    && apt-get install -y --no-install-recommends tzdata wget net-tools\
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata \
    && wget --no-check-certificate https://down.oray.com/hsk/linux/$PACKAGE_NAME \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get autoremove -y

CMD dpkg -i $PACKAGE_NAME && tail -f /var/log/phddns/phtunnel.log