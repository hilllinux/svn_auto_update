#! /bin/bash                                                                                                                  

base_path=/home/svn
info_path=${base_path}/post-release
flag_path=${base_path}/flag
log_path=${base_path}/log
remote_path=pandora:/home/wangsongqing/auto_svn_update

if [ ! -f "$info_path" ]; then
    exit;
fi

time_of_info_file=`stat -c %Y ${info_path}`
time_of_flag_file=0

if [ -f "$flag_path" ]; then
    time_of_flag_file=`stat -c %Y ${flag_path}`
fi

if [ $time_of_flag_file -lt $time_of_info_file ]; then
    echo "`date`:start copy to remote address" >> $log_path
    scp $info_path $remote_path >> $log_path
    touch $flag_path
fi
