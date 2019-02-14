FROM lsiobase/xenial
MAINTAINER Ryan Flagler

# global environment settings
ENV IVIDEON_VERSION="3.7.1" \
DEBIAN_FRONTEND="noninteractive" \
IVIDEON_REPO="http://packages.ivideon.com/ubuntu/keys/ivideon.list" \
IVIDEON_KEY="http://packages.ivideon.com/ubuntu/keys/ivideon.key"

# install packages
RUN \
 apt-get update && \
 apt-get install -y \
	libgl1-mesa-glx \
	wget && \

# install ivideon
 curl -o \
	/etc/apt/sources.list.d/ivideon.list -L \
	"${IVIDEON_REPO}" && \
 wget -O - "${IVIDEON_KEY}" | apt-key add - && \
 apt-get update && \
 apt-get install -y \
	ivideon-video-server && \
	
# cleanup
 apt-get clean && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8080 3101 443 80
VOLUME /config /archive
