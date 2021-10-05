# Build:                   sudo docker build --no-cache . -t cacophony-api
# Run interactive session: sudo docker run -it cacophony-api

FROM golang:latest

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y supervisor
RUN apt-get install -y dbus
RUN mkdir -p /var/run/dbus
RUN apt-get install -y dbus iputils-ping

RUN mkdir -p /etc/salt
RUN touch /etc/salt/minion_id
RUN mkdir -p /var/log/supervisor

RUN go get github.com/gobuffalo/packr/packr

COPY go* /dependencies/
WORKDIR /dependenciesf
RUN ls -R


# server for automated testing
EXPOSE 2040
EXPOSE 80
COPY  thermal-recorder.conf /etc/supervisor/conf.d/thermal-recorder.conf
COPY  thermal-uploader.conf /etc/supervisor/conf.d/thermal-uploader.conf
COPY  event-reporter.conf /etc/supervisor/conf.d/event-reporter.conf
COPY  management-interface.conf /etc/supervisor/conf.d/management-interface.conf
COPY  docker-entrypoint.sh /
RUN mkdir -p /etc/cacophony
RUN mkdir -p /var/spool/cptv

COPY recorder-config.toml /etc/cacophony/config.toml

ENTRYPOINT ["/docker-entrypoint.sh"]
