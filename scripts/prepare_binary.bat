:: The script will create a binary file and copy the golang code to temp directory.

:: Create binary and move it to temp directory.
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

:: Move golang code to temp directory.
set code_path="d:\cygwin64\\home\SYSTEM\_build\code"
if exist %code_path% (
    echo "Remove existed %code_path%."
    rmdir %code_path% /s/q
) 
md %code_path%

xcopy server %code_path% /i /o /y /s

echo "Print structure of the directories."
D:\cygwin64\bin\bash --login -c "ls _build"
