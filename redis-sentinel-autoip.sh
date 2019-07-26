#!/bin/bash
# 客户端程序（如PHP程序）连接redis时需要ip和port，但redis-server进行故障转移时，主数据库是变化的，所以ip地址也是变化的，客户端程序如何感知当前主redis的ip地址和端口呢？
# redis-sentinel提供了接口，请求任何一个sentinel，发送SENTINEL get-master-addr-by-name <master name>就能得到当前主redis的ip和port。
#
# 解决方案：
#    增加配置切换脚本 sentinel.conf，当主数据库服务宕机时，实现VIP漂移自动切换主从。
#    sentinel client-reconfig-script mymaster /usr/local/redis/conf/reconfig.sh
#
# EXAMPLE:
#    mymaster leader start 192.168.4.11 6379 192.168.4.12 6379
VIP="192.168.4.2/24"
local_ip=$(ip  addr show dev eth0 |awk '$1=="inet"{print $2}')
if [[ "${local_ip%%/*}" == "$4" ]];then
   /usr/sbin/ifconfig eth0:1 down
elif [[ "${local_ip%%/*}" == "$6" ]];then
   /usr/sbin/ifconfig eth0:1 "${VIP}"
fi
