#! /bin/bash

base_path=/home/wangsongqing/auto_svn_update
info_path=${base_path}/post-release
flag_path=${base_path}/flag
log_path=${base_path}/log
nginx_config_file_dir=/etc/nginx/conf/conf.d
svn=/usr/bin/svn
svn_username=wangsongqing
svn_passwd=1moodadmin

if [ ! -f "$info_path" ]; then 
    exit;
fi

time_of_info_file=`stat -c %Y ${info_path}`
time_of_flag_file=0

if [ -f "$flag_path" ]; then
    time_of_flag_file=`stat -c %Y ${flag_path}`
fi

if [ $time_of_flag_file -lt $time_of_info_file ]; then

    while read line; do 
        project=$(echo $line | awk '{print $1}');
        svn_path=$(echo $line | awk '{print $2}');

        for i in $(grep $project ${nginx_config_file_dir}/* | awk '{print $3}' | awk -F ';' '{print $1}'); do
            update_path=${i}/${svn_path}
            if [ -d $update_path ]; then
                date >> $log_path
                $svn up --username $svn_username --password $svn_passwd $update_path  >> $log_path
            fi
        done

        #echo "$project:$svn_path"
    done < $info_path

    touch $flag_path
fi

