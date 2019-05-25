#!/bin/bash
#
#自己练习用的脚本
#基于RANDOM的随机密码生成器(基础版)
#
#测试环境CentOS7
#
#By AndyX 2019-5



#定义变量,dd可以不写但是感觉不爽所以还是写了,x写入需要调用的字符串
dd=
x=abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ


#进入循环,密码长度20位(随机从x变量取1个字符,使用dd叠加20次)
for i in {1..20}
  do
    r=$[RANDOM%62]           #调用系统内置RANDOM,取余限制获取x的位数

    haha=${x:r:1}            #截取变量x,位数1,位置随机

    dd=$dd$haha              #每次循环叠加1,循环20次形成密码
  done


#输出随机密码
echo $dd
