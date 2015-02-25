#!/bin/bash

cd ~
rm -rf go; git clone https://go.googlesource.com/go -b release-branch.go1.4 go
rm -rf golang-crosscompile; git clone git://github.com/davecheney/golang-crosscompile.git;
source golang-crosscompile/crosscompile.bash
(cd go/src && go-crosscompile-build-all)
rm -rf golang-crosscompile
go get golang.org/x/tools/cmd/goimports golang.org/x/review/git-codereview github.com/tools/godep golang.org/x/tools/cmd/vet github.com/golang/lint/golint golang.org/x/tools/cmd/cover

#gotiplinux:
#	cd ~; curl https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz | tar xz; \
#	mv go go1.4; \
#	git clone https://go.googlesource.com/go; \
#	(cd go/src && ./make.bash)
#	go get golang.org/x/tools/cmd/goimports golang.org/x/review/git-codereview github.com/tools/godep golang.org/x/tools/cmd/vet github.com/golang/lint/golint golang.org/x/tools/cmd/cover

