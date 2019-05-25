#!/bin/bash
#
#自己练习用的脚本,基于ping命令的简易扫描器(并发基础版)
#
#测试环境CentOS7
#
#By AndyX 2019-5


#定义函数myping
myping(){
    ping -c1 -W1 -i0.2 $1 &> /dev/null          #调用ping命令快速探测
    if [ $? -eq 0 ]; then                       #判断返回值若真则输出绿色的XXX is up
       echo -e "\e[32m $1 is up\e[0m"
    else                                        #判断返回值若假则输出红色的XXX is down
       echo -e "\e[31m $1 is down\e[0m"
    fi
}


#调用myping函数,循环扫描网段1至254,迸发扫描
for i in {1..254}
    do
       myping 172.88.14.$i &
       sleep 0.01
    done

wait
