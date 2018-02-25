# PJSIP/PJSUA
#
# VERSION               0.0.3

FROM buildpack-deps:jessie

WORKDIR /tmp

RUN apt-get update -yy && \
    apt-get install -yy \
        alsa-utils libasound2-dev

RUN wget http://www.pjsip.org/release/2.7.1/pjproject-2.7.1.tar.bz2 && \
    tar -xjf pjproject-2.7.1.tar.bz2 && \
    cd pjproject-2.7.1/ && \
    ./configure && \
    make dep && make && \
    make install && \
    cp pjsip-apps/bin/pjsua* /usr/local/bin/pjsua && \
    cd .. && rm -rf pjproject-2.7.1 && rm -rf *.tar.bz2 && \
    rm -rf /var/cache/apt/* /tmp/* /var/tmp/*

COPY ./pjsua.conf           /pjsua.conf

COPY ./start.sh /
RUN chmod +x /start.sh

CMD /start.sh
