# Build:                   sudo docker build --no-cache . -t cacophony-api
# Run interactive session: sudo docker run -it cacophony-api

FROM golang:latest

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y supervisor

RUN apt-get install -y dbus iputils-ping

RUN mkdir -p /var/run/dbus
RUN mkdir -p /etc/salt
RUN touch /etc/salt/minion_id
RUN mkdir -p /var/log/supervisor

RUN go get github.com/gobuffalo/packr/packr

COPY go* /dependencies/
WORKDIR /dependencies
RUN ls -R
RUN go mod download
COPY other/go* ./
RUN go mod download

# server for automated testing
EXPOSE 2040
EXPOSE 80
COPY  thermal-recorder.conf /etc/supervisor/conf.d/thermal-recorder.conf
COPY  thermal-uploader.conf /etc/supervisor/conf.d/thermal-uploader.conf
COPY  event-reporter.conf /etc/supervisor/conf.d/event-reporter.conf

COPY  docker-entrypoint.sh /
RUN mkdir /etc/cacophony
RUN mkdir /var/spool/cptv

COPY recorder-config.toml /etc/cacophony/config.toml

ENTRYPOINT ["/docker-entrypoint.sh"]
