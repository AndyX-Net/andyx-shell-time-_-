#!/bin/bash
#
#自己练习用的脚本
#用于交互式在KVM虚拟环境下快速自动配置IP地址-网关-YUM源地址
#
#测试环境CentOS7
#
#By AndyX 2019-7



confip(){
ip1=$(echo $ip | awk -F "." '{print $1}')
ip2=$(echo $ip | awk -F "." '{print $2}')
ip3=$(echo $ip | awk -F "." '{print $3}')

#定义kvm中默认环境网关地址
eip=${ip1}.${ip2}.${ip3}.254

#写入yum源地址(模拟环境yum源指向真实服务器,即网关)
sip=$(grep baseurl /etc/yum.repos.d/local.repo | awk -F "/" '{print $3}') &> /dev/null
sed  -i "/baseurl/s/${sip}/${eip}/" /etc/yum.repos.d/local.repo 
}




#调用nmcli命令进行相关网络参数配置
network(){
if [ -z $gw ];then
 nmcli connection modify $name ipv4.method manual ipv4.addresses $ip connection.autoconnect yes &> /dev/null
 if [ $? -ne 0 ];then
  echo 'Network Address Error'
 fi
 nmcli connection up $name
 confip 
else
 nmcli connection modify $name ipv4.method manual ipv4.addresses $ip ipv4.gateway $gw connection.autoconnect yes &> /dev/null
 if [ $? -ne 0 ];then
  echo 'Network Address Error'
 fi
 nmcli connection up $name
 confip 
fi
}




#交互式问答开始
read  -p  'Network name(eth0/eth1/eth2/eth3):'  name
read  -p  'Set IP(IP/24):'  ip
read  -p  'Set Gateway(default none):'  gw



#简单判断与循环
if [ -z $name ] || [ -z $ip ];then
 echo -e "\e[31;1mPlease enter parameters\e[0m"
 exit
fi
echo $ip | grep /24
if [ $? -ne 0 ];then
  echo -e "\e[31;1mNetwork Address Error\e[0m"
  exit
fi

case $name in
   eth0)
   network;;
   eth1)
   network;;
   eth2)
   network;;
   eth3)
   network;;
   *)
   echo -e "\e[31;1mNetwork Address Error\e[0m"
esac

