#!/bin/bash
#
#自己练习用的SHELL脚本,用于花式显示倒计时(v1.0)
#
#测试环境CentOS7
#
#By AndyX 2019-5


#预定义
er=(22 1 1 1 2 1 3 2 3 3 1 3 2 3 3 4 1 5 1 5 2 5 3)
san=(22 1 1 1 2 1 3 2 3 3 1 3 2 3 3 4 3 5 1 5 2 5 3)
yi=(10 1 2 2 2 3 2 4 2 5 2 )
si=(18 1 1 1 3 2 1 2 3 3 1 3 2 3 3 4 3 5 3)
wu=(22 1 1 1 2 1 3 2 1 3 1 3 2 3 3 4 3 5 1 5 2 5 3)
liu=(24 1 1 1 2 1 3 2 1 3 1 3 2 3 3 4 1 4 3 5 1 5 2 5 3)
qi=(14 1 1 1 2 1 3 2 3 3 3 4 3 5 3)
ba=(26 1 1 1 2 1 3 2 1 2 3 3 1 3 2 3 3 4 1 4 3 5 1 5 2 5 3)
jiu=(24 1 1 1 2 1 3 2 1 2 3 3 1 3 2 3 3 4 3 5 1 5 2 5 3)
ling=(24 1 1 1 2 1 3 2 1 2 3 3 1 3 3 4 1 4 3 5 1 5 2 5 3)

#函数与判断
xian(){
shu=$1
jian=$2
if [ ${shu} -eq 0 ];then
   lang=${ling[0]}
   xianshi=(${ling[*]})
elif [ ${shu} -eq 1 ];then
   lang=${yi[0]}
   xianshi=(${yi[*]})
elif [ ${shu} -eq 2 ];then
   lang=${er[0]}
   xianshi=(${er[*]})
elif [ ${shu} -eq 3 ];then
   lang=${san[0]}
   xianshi=(${san[*]})
elif [ ${shu} -eq 4 ];then
   lang=${si[0]}
   xianshi=(${si[*]})
elif [ ${shu} -eq 5 ];then
   lang=${wu[0]}
   xianshi=(${wu[*]})
elif [ ${shu} -eq 6 ];then
   lang=${liu[0]}
   xianshi=(${liu[*]})
elif [ ${shu} -eq 7 ];then
   lang=${qi[0]}
   xianshi=(${qi[*]})
elif [ ${shu} -eq 8 ];then
   lang=${ba[0]}
   xianshi=(${ba[*]})
elif [ ${shu} -eq 9 ];then
   lang=${jiu[0]}
   xianshi=(${jiu[*]})
else
   echo "error"
fi


#显示字符
for i in `seq 1 2 $lang`
do
   hang1=`echo ${xianshi[i]}`
   lie1=`echo ${xianshi[i+1]}`
   let lie2=lie1+jian
   echo -en "\033[${hang1};${lie2}H${shu}"
done

}


#主循环与函数调用
for i in {99..1}
do
  clear
  
  let shi=i/10
  let ge=i%10
 
  xian ${shi} 0
  xian ${ge} 5
  sleep 1
done
