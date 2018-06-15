#/bin/bash

monitor(){    
	rx_bytes=`cat /proc/net/dev|grep $1|awk '{print $2}'`
	tx_bytes=`cat /proc/net/dev|grep $1|awk '{print $10}'`
	rx_p=`cat /proc/net/dev|grep $1|awk '{print $3}'`
	tx_p=`cat /proc/net/dev|grep $1|awk '{print $11}'`
	sleep 1
	rx_bytes_1=`cat /proc/net/dev|grep $1|awk '{print $2}'`
	tx_bytes_1=`cat /proc/net/dev|grep $1|awk '{print $10}'`
	
	io_rkB=`iostat -d -x -k | grep sda | awk '{print $6}'`
	io_wkB=`iostat -d -x -k | grep sda | awk '{print $7}'`
	io_util=`iostat -d -x -k | grep sda | awk '{print $14}'`
	
	RX=$((${rx_bytes_1}-${rx_bytes}))
	TX=$((${tx_bytes_1}-${tx_bytes}))
	 
	if [[ $RX -lt 1024 ]];then
		RX="${RX}B/s"
	elif [[ $RX -gt 1048576 ]];then
		RX=$(echo $RX | awk '{print $1/1048576 "MB/s"}')
	else
		RX=$(echo $RX | awk '{print $1/1024 "KB/s"}')
	fi
	  
	if [[ $TX -lt 1024 ]];then
		TX="${TX}B/s"
	elif [[ $TX -gt 1048576 ]];then
		TX=$(echo $TX | awk '{print $1/1048576 "MB/s"}')
	else
		TX=$(echo $TX | awk '{print $1/1024 "KB/s"}')
	fi

	printf "%-10s %-20.2f %-20.2f %-20.2f %-20.2f %-20s %-20s %-20.2f %-20.2f %-4.2f\n" $1 $rx_bytes $tx_bytes $rx_p $tx_p $RX $TX $io_rkB $io_wkB $io_util;
}

printf "%-10s %-20s %-20s %-20s %-20s %-20s %-20s %-20s %-20s %-4s\n" interface rxM\(bytes\) txM\(bytes\) rxP\(bytes\) txP\(bytes\) RX\(KB/M/s\) TX\(KB/M/s\) IOrkB\(kb/s\) IOwkB\(kb/s\) IOutil\(%\);

while true; do
    monitor eth0
    #for i in `ls /sys/class/net/`; do
		#monitor $i
    #done
    sleep 2
done
