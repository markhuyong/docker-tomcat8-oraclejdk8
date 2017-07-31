FROM jeanblanchard/tomcat:8
MAINTAINER markhuyong <markhuyong@gmail.com>

# add windows fonts
ADD ./fonts /usr/share/fonts

RUN set -ex && \
    apk upgrade --update && \
    apk add --update fontconfig mkfontscale mkfontdir && \
    mkfontscale && mkfontdir && fc-cache

# add chromnium
RUN apk update && \
	apk add chromium chromium-chromedriver

#add phantomjs
ENV PHANTOMJS_ARCHIVE="phantomjs.tar.gz"
RUN apk update && \
	apk add curl

RUN set -ex && curl -Lk -o $PHANTOMJS_ARCHIVE https://github.com/fgrehm/docker-phantomjs2/releases/download/v2.0.0-20150722/dockerized-phantomjs.tar.gz \
	&& tar -xf $PHANTOMJS_ARCHIVE -C /tmp/ \
	&& cp -R /tmp/etc/fonts /etc/ \
	&& cp -R /tmp/lib/* /lib/ \
	&& cp -R /tmp/lib64 / \
	&& cp -R /tmp/usr/lib/* /usr/lib/ \
	&& cp -R /tmp/usr/lib/x86_64-linux-gnu /usr/ \
	&& cp -R /tmp/usr/share/* /usr/share/ \
	&& cp /tmp/usr/local/bin/phantomjs /usr/bin/ \
	&& rm -fr $PHANTOMJS_ARCHIVE  /tmp/*

EXPOSE 8080
CMD ${CATALINA_HOME}/bin/catalina.sh run
