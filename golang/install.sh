mkdir -p $HOME/golang/src
export GOPATH=$HOME/golang
go get golang.org/x/tools/cmd/godoc
go get -u github.com/golang/lint/golint
