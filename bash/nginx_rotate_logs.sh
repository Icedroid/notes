# /bin/bash
#添加到系统定时任务中crontab -e
# 0 0 1 * * sh /opt/nginx/logs/nginx_rotate_logs.sh >/dev/null 2>&1
# 日志保存位置
base_path='/opt/nginx/logs'
# 获取当前年信息和月信息
log_path=$(date -d yesterday +"%Y%m")
# 获取昨天的日信息
day=$(date -d yesterday +"%d")
# 按年月创建文件夹
mkdir -p $base_path/$log_path
# 备份昨天的日志到当月的文件夹
mv $base_path/access.log $base_path/$log_path/access_$day.log
# 输出备份日志文件名
# echo $base_path/$log_path/access_$day.log
# 向Nginx Master进程发送重新打开日志文件信号
kill -USR1 $(cat /opt/nginx/logs/nginx.pid)