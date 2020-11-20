FROM lsiobase/xenial
MAINTAINER Ryan Flagler

# global environment settings
ENV IVIDEON_VERSION="3.9.0" \
DEBIAN_FRONTEND="noninteractive" \
IVIDEON_REPO="https://packages.ivideon.com/ubuntu/keys/ivideon.list" \
IVIDEON_KEY="https://packages.ivideon.com/ubuntu/keys/ivideon.key"

# install packages
RUN \
 apt-get update && \
 apt-get install -y \
	libgl1-mesa-glx \
	sudo \
	libqt5gui5 \
	libqt5core5a \
	gcc-7-base \
	libfacesdk \
	libfacesdk-data \
	libstdc++6 \
	wget && \

# install ivideon
 curl -ko \
	/etc/apt/sources.list.d/ivideon.list -L \
	"${IVIDEON_REPO}" && \
 curl -kfsSL "${IVIDEON_KEY}" | apt-key add - && \
 apt-get update && \
 apt-get install -y \
	ivideon-video-server \
	ivideon-server-faces-tv-module && \
 apt-get upgrade && \
	
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
