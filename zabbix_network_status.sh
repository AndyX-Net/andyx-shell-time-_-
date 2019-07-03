#!/bin/bash
#
#自己练习用的SHELL脚本,用于zabbix自动监控-系统网络状态反馈
#
#测试环境CentOS7
#
#By AndyX 2019-7


case $1 in
estab)
    ss -antp |awk '/^ESTAB/{x++} END{print x}';;
close_wait)
    ss -antp |awk '/^CLOSE-WAIT/{x++} END{print x}';;
time_wait)
    ss -antp |awk '/^TIME-WAIT/{x++} END{print x}';;
esac 
