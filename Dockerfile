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

EXPOSE 8080
CMD ${CATALINA_HOME}/bin/catalina.sh run
