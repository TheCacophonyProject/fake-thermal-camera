module github.com/TheCacophonyProject/fake-thermal-camera

replace periph.io/x/periph => github.com/TheCacophonyProject/periph v1.0.1-0.20200331204442-4717ddfb6980

go 1.12

require (
	github.com/TheCacophonyProject/go-config v1.4.0
	github.com/TheCacophonyProject/go-cptv v0.0.0-20200225002107-8095b1b6b929
	github.com/TheCacophonyProject/lepton3 v0.0.0-20200430221413-9df342ce97f9
	github.com/TheCacophonyProject/thermal-recorder v1.22.1-0.20200225033227-2090330c5c11
	github.com/alexflint/go-arg v1.3.0
	github.com/fsnotify/fsnotify v1.5.1 // indirect
	github.com/godbus/dbus v4.1.0+incompatible
	github.com/gorilla/mux v1.7.4
	github.com/markbates/refresh v1.12.0 // indirect
	github.com/spf13/viper v1.8.1 // indirect
	gopkg.in/check.v1 v1.0.0-20190902080502-41f04d3bba15 // indirect
	gopkg.in/yaml.v1 v1.0.0-20140924161607-9f9df34309c0
)
