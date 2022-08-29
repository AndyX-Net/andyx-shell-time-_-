#!/bin/bash
# 
#一个用于快速故障排查OOM的脚本
#支持分析不同Linux版本中的Message/Syslog日志
#
#推荐在Ubuntu OS环境中运行
#
#By AndyX 2022.08.29

#function usage means how to use this script.
usage()
        {
                echo -e "\nUsage: \e[1m $0 logfile \e[0m\n"
                echo -e "For example:\n\e[1;32m $0 message.log \e[0m \n"
                echo -e "\e[1mIt is recommended to run this script in Ubuntu environment \e[0m\n"
        }

#if no parameter is passed to script then show how to use.
        if [ $# -eq 0 ];
        then
                usage
                exit
        fi

#Start auto analyzer.
cat $1 | grep kernel | rev | cut -d"]" -f1 | rev | awk '{ print $3, $4, $5, $8 }' | perl -MData::Dumper -p -e 'BEGIN { $db = {}; } ($total_vm, $rss, $pgtables_bytes, $name) = split; $db->{$name}->{total_vm} += $total_vm; $db->{$name}->{rss} += $rss; $db->{$name}->{pgtables_bytes} += $pgtables_bytes; $_=undef; END { map { printf("%.1fG %s\n", ($db->{$_}->{rss} * 4096)/(1024*1024*1024), $_) } sort { $db->{$a}->{rss} <=> $db->{$b}->{rss} } keys %{$db}; }' | tail -n 10 | tac
