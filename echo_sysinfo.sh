#!/bin/bash
#
#自己练习用的脚本
#用于显示系统信息的SHELL脚本,基于常用基本命令的一句话脚本(一句话版)
#
#测试环境CentOS7
#
#By AndyX 2019-5



echo -e "\nCPU负载"$(uptime | awk '{print $NF}')"\n网卡流量"$(ifconfig eth0 | awk '/RX p/{print $5/1024/1024"MB"}')"\n剩余内存"$(free -h | awk '/^Mem/{print $4}')"\n磁盘剩余容量"$(df -h | awk '/\$/{print $4}')"\n计算机账户数量"$(cat /etc/passwd | wc -l)"\n当前登录数量"$(who | wc -l)"\n当前计算机进程数"$(ps aux | wc -l)"\n本机安装软件包数量"$(rpm -qa | wc -l)"\n"
