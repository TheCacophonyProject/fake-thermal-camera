#!/bin/bash
echo --- device-register ----
cd /code/device-register
echo Building device-register ....
go build ./...

echo --starting dbus --
dbus-daemon --config-file=/usr/share/dbus-1/system.conf --print-address

echo --- event-reporter ----
cd /code/event-reporter
cd cmd/event-reporter/
echo Building event-reporter ....
go build
cp ../../_release/org.cacophony.Events.conf /etc/dbus-1/system.d/org.cacophony.Events.conf

echo --- thermal-recorder ----
cd /code/thermal-recorder/cmd/thermal-recorder
echo Building thermal-recorder....
go build ./...
cp    "../../_release/org.cacophony.thermalrecorder.conf" "/etc/dbus-1/system.d/org.cacophony.thermalrecorder.conf"
echo Running thermal recorder...

echo --- thermal-uploader ----
cd /code/thermal-uploader/
echo Building thermal-uploader....
go build ./...

echo --- management interface ----
cd /code/management-interface/
echo Building management-interface....
make build
echo --starting dbus --
dbus-daemon --config-file=/usr/share/dbus-1/system.conf --print-address

echo --- starting supervisord ---
/usr/bin/supervisord &
disown

echo '*************************************************'
echo 'Camera UI screen will be available on http://localhost:2041'
echo 'The test server will be available on http://localhost:2040 (after build finishes)'
echo 'See README.md for how to use the server'
echo '*************************************************'

echo --- test-server ----
cd /server/cmd/testing-server/
echo Building and running test-server....
go get github.com/markbates/refresh
refresh init -c refresh.yml
refresh run
