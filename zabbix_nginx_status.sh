#!/bin/bash
#
#自己练习用的SHELL脚本,用于zabbix自动监控-nginx流量反馈
#
#测试环境CentOS7
#
#By AndyX 2019-7


#定义nginx主机IP
ip=192.168.0.22

#定义nginx状态反馈目录
statusdir=status


case $1 in
active)
    curl -s http://$ip/$statusdir |awk '/Active/{print $NF}';;
waiting)
    curl -s http://$ip/$statusdir |awk '/Waiting/{print $NF}';;
accepts)
    curl -s http://$ip/$statusdir |awk 'NR==3{print $2}';;
esac
