#!/bin/bash
#
#收集整理之前写的脚本
#简单实现当LVS后端机掉线时用于自动辅助剔除掉线主机
#脚本放置在LVS所在主机
#
#测试环境CentOS7
#
#By AndyX 2018-4


VIP=192.168.4.15:80
RIP1=192.168.4.100
RIP2=192.168.4.200
while :
do
   for IP in $RIP1 $RIP2
   do
	       curl -s http://$IP &>/dev/vnull
if [ $? -eq 0 ];then
            ipvsadm -Ln |grep -q $IP || ipvsadm -a -t $VIP -r $IP
        else
             ipvsadm -Ln |grep -q $IP && ipvsadm -d -t $VIP -r $IP
        fi
   done
sleep 1
done
