SET ARG="%1"

if "%ARG%"=="stage"(
    D:\cygwin64\bin\bash --login -c "cd ansible && ansible-playbook stage.yml -vvv"
)
else (
    D:\cygwin64\bin\bash --login -c "cd ansible && ansible-playbook prodction.yml -vvv"
)
