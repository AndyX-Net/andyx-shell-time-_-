#!/bin/bash
#
#自己练习用的脚本
#用于自动切割NGINX日志文件,防止日志过大
#简易结合corntab创建周期计划使用
#
#测试环境CentOS7,Nginx1.15自编译
#
#By AndyX 2019-6

#定义时间变量,格式年月日
date=`date +%Y%m%d`

#定义默认日志路径,本人测试于CentOS7,其他系统可能路径不同,需要自行修改
logpath=/usr/local/nginx/logs

#开始切割
mv $logpath/access.log $logpath/access-$date.log
mv $logpath/error.log $logpath/error-$date.log
kill -USR1 $(cat $logpath/nginx.pid)
