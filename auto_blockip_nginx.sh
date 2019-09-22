#!/bin/sh
#自动屏蔽扫描器脚本By  AndyX.Net  2019.09

#获取当前时间格式：yyyy-mm-dd
dd=`date +%F`
#日志文件路径
path='/var/log/nginx/access.log'
#nginx 黑名单路径文件
blocklist_path=/etc/nginx/block.ip
#出现匹配关键字则记录
keyword1=phpmy
keyword2=\\x09
keyword3=\\xA7
keyword4=.asp
keyword5=\\xA3
keyword6=Nmap
keyword7=mysql
keyword8=cgi
keyword9=\\xD7

#获取ip出现次数按照降序排列并输出到文件
`grep -iE "$keyword1|$keyword2|$keyword3|$keyword4|$keyword5|$keyword6|$keyword8|$keyword9" $path |  awk '{print $1}' | grep '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' -o | sort -k1,1nr | uniq -c | sort -k1,1nr > /tmp/blockip.${dd}.list`
#ip列表文件
ip_path=/tmp/blockip.${dd}.list
#索引
ip_index=1
#ip出现次数
ip_show=0
#ip写入次数
ip_write=0
#设定统计IP违规多少次时触发
set_count=2
for line in `cat $ip_path`
do
    fanwei=$(( $ip_index % 2 ))
    ip_index=`expr $ip_index + 1`
    if [ $fanwei -eq 1 ] ; then
       ip_show=$(( $line + 0 ))
    else
        if [ $ip_show -gt $set_count ] ; then
            ip=$line
            ip_count=$(( `cat $blocklist_path | grep -c $ip` ))
            if [ $ip_count -eq 1 ] ; then
                ip_show=0
                continue;
            else
                ip_write=`expr $ip_write + 1`
                `echo 'deny '$ip';' >> $blocklist_path`
            fi
            ip_show=0
        fi
        ip_show=0
    fi
done

# 如果有数据写入则重新加载 nginx
if [ $ip_write -gt 0 ] ; then
    nginx -s reload
fi
#清理临时文件
rm -rf $ip_path
