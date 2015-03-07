tool for svn autoupdate by using svn commit hook

1. mv post-commit repos/hooks
2. add svn server private to the WEB target machine's ssh authorized_keys.
3. run svn_scp.sh crontab job uing root role in svn build machine.
4. run auto_up.sh crontab job using root role in target machine.
