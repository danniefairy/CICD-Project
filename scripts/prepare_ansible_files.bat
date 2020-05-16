:: The script will update the ansible_dir in cygwin.
set ansible_dir="d:\cygwin64\\home\user\ansible_dir"
if exist %ansible_dir% (
    echo "Remove existed %ansible_dir%."
    rmdir %ansible_dir% /s/q
) 
md %ansible_dir%
xcopy ansible_dir %ansible_dir% /i /o /y
D:\cygwin64\bin\bash --login -c "ls ansible_dir"
