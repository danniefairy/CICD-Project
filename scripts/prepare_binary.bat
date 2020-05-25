:: The script will create a binary file to temp directory.
set bin_path="d:\cygwin64\\home\SYSTEM\_build\bin"
if exist %bin_path% (
    echo "Remove existed %bin_path%."
    rmdir %bin_path% /s/q
) 
md %bin_path%

pushd "%cd%/server"
set GOOS=linux
go build -o "%bin_path%/srv" ./server/main.go 
popd

echo "Print structure of the directories."
D:\cygwin64\bin\bash --login -c "tree /f"
