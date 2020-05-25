set bin_path="%cd%/_build/bin"
if exist %bin_path% (
    echo "Remove existed %bin_path%."
    rmdir %bin_path% /s/q
) 
md %bin_path%
pushd "%cd%/server"
set GOOS=linux
go build -o "%bin_path%/srv" ./server/main.go 
popd
tree /f
