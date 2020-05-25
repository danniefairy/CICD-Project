set bin_path="%cd%/_build/bin"
md %bin_path%
pushd "%cd%/server"
set GOOS=linux
go build -o "%bin_path%/srv" ./server/main.go 
popd
tree /f
