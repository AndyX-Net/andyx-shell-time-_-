#!/bin/bash
#
#自己练习用的脚本
#用于交互式一键生成新虚拟机的SHELL脚本(使用qemu-img的COW前端盘技术)
#
#测试环境CentOS7
#
#By AndyX 2019-7

#引用文件
. /etc/clone.conf 


#如果clone.conf中name值为空,则选用前端目标node_andyx克隆,否则选用前端目标node_base克隆
if [ "$name" == "" ];then
 BASEVM=node_andyx
else
 BASEVM=node_base
 echo -e "The basic template you use \e[32;1m[OK]\e[0m"
fi



#定义前端镜像目录
IMG_DIR=/var/lib/libvirt/images


#交互定义并创建虚拟机
read -p "Enter VM number: "   VMNUM

#如果为空,则输出错误,并终止运行
if [ -z $VMNUM  ];then
echo    Please enter parameters
exit
fi

#如果为字符串或者0,则输出错误,并终止运行.数值限定范围为1至99
if [ -z "${VMNUM}" ]; then
    echo "You must input a number."
    exit 65
elif [ $(echo ${VMNUM}*1 | bc) = 0 ]; then
    echo "You must input a number."
    exit 66
elif [ ${VMNUM} -lt 1 -o ${VMNUM} -gt 99 ]; then
    echo "Input out of range"
    exit 67
fi

#自动位数补齐
if [ $VMNUM -le 9 ];then
VMNUM=0$VMNUM
fi

#生成前端盘名称
NEWVM=andyx_node${VMNUM}

#前端判若存在则终止运行
if [ -e $IMG_DIR/${NEWVM}.img ]; then
    echo "File exists."
    exit 68
fi


#开始创建前端盘,并且定义xml虚拟机配置文件
echo -en "Creating Virtual Machine disk image......\t"

#依据后端BASEVM生成前端NEWVM虚拟磁盘,大小20G
qemu-img create -f qcow2 -b $IMG_DIR/.${BASEVM}.qcow2 $IMG_DIR/${NEWVM}.img 20G &> /dev/null
echo -e "\e[32;1m[OK]\e[0m"
if [ "$name" == "" ];then
cat /var/lib/libvirt/images/.node_andyx.xml > /tmp/myvm.xml
else
cat /var/lib/libvirt/images/.node_base.xml > /tmp/myvm.xml
fi

#替换定义新的虚拟机配置文件
sed -i "/<name>${BASEVM}/s/${BASEVM}/${NEWVM}/" /tmp/myvm.xml
sed -i "/${BASEVM}\.img/s/${BASEVM}/${NEWVM}/" /tmp/myvm.xml

echo -en "Defining new virtual machine......\t\t"
sudo virsh define /tmp/myvm.xml &> /dev/null
rm -rf /tmp/myvm.xml
echo -e "\e[32;1m[OK]\e[0m"
