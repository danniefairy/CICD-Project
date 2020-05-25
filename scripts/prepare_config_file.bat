SET ARG=%1

pushd "d:/cygwin64/home/SYSTEM/ansible"
if "%ARG%"=="stage"(
    D:\cygwin64\bin\bash --login -c "ansible-playbook stage.yml -vvv"
)
else (
    D:\cygwin64\bin\bash --login -c "ansible-playbook prodction.yml -vvv"
)
popd
