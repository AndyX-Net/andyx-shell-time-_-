#!/bin/bash
echo "options kvm-intel nested=1
options kvm-intel enable_shadow_vmcs=1
options kvm-intel enable_apicv=1
options kvm-intel ept=1" > /etc/modprobe.d/kvm-nested.conf
modprobe -r kvm_intel
if [ $? -ne 0 ];then
    echo "关闭所有虚拟机后重新尝试"
    exit
fi
modprobe -a kvm_intel
echo -e "\033[32m***OK***\033[0m"
