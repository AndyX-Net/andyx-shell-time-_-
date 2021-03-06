#!/bin/bash
# TsengYia 2016.06.25
#num=$(hostname -s | grep -oE '[0-9]+$')
[ -z "$num" ] && num=0
system1="server$num"
system2="desktop$num"
execdir="/home/student/bin"
grade() {
	if [ "$1" == "${system1}" ] ; then
		start_sh="RHCE-server0.sh"
	else
		start_sh="RHCE-desktop0.sh"
	fi
	scp $execdir/${start_sh} root@$1:/tmp/ &> /dev/null
	if [ $? -ne 0 ] ; then
	    echo "Error 44: $1.${domain} unreachable"
	    exit 1
	fi
	ssh root@$1 "source /tmp/${start_sh} ; rm -rf /tmp/${start_sh}"
}
grade $system1
echo
#read -n1 -t 30 -p "Press any key to continue" ch
sleep 2
echo
grade $system2

for host in $system1 $system2
do
    let oks+=$(ssh root@$host 'grep -cw pass /tmp/pass.rec')
    let faileds+=$(ssh root@$host 'grep -cw failed /tmp/pass.rec')
done
echo
echo "Lab-Check finished, 
your pass-rate is $(echo "scale=2;$oks*100/($oks+$faileds)" | bc)%，except "skiped" item."
echo
