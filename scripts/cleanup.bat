:: The script will clean up the ansible dir and containers if the pipeline fails.
rmdir d:\cygwin64\home\SYSTEM\ansible /s /q
rmdir d:\cygwin64\home\SYSTEM\_build /s /q
docker ps --filter name=server* -aq | xargs docker stop | xargs docker rm
