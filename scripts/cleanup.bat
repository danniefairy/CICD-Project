:: The script will clean up the ansible dir and containers if the pipeline fails.
rmdir d:\cygwin64\home\user\ansible_dir /s /q
docker rm -f stage_env prod_env