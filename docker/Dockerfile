FROM ubuntu:15.04 

RUN sed -e 's/archive/se.archive/' -i /etc/apt/sources.list
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:inkscape.dev/trunk
RUN apt-get -y build-dep inkscape
RUN apt-get -y install bzr ccache autopoint

RUN mkdir -p /app/src
WORKDIR /app
VOLUME /app/src

COPY build.sh /app/

CMD /app/build.sh
