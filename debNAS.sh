#!/bin/bash
host="192.168.42.3"

if [ $@ == "start" ];
then
	echo "debNAS Start is triggered";
	sudo /usr/sbin/etherwake b4:2e:99:2e:82:ac
	echo "ON" > /home/fauxmo/debNAS.data
	exit 0;
fi
	if [ $@ == "stop" ];
then
	echo "debNAS Stop is triggered";
	echo "OFF" > /home/fauxmo/debNAS.data
	/usr/bin/ssh -i /home/fauxmo/nascontrol nascontrol@$host 'sudo shutdown now' > /dev/null
	exit 0;
fi
if [ $@ == "status" ];
then
	if [ -e "/home/fauxmo/debNAS.data" ]; then
		var=`cat /home/fauxmo/debNAS.data`;
	else
		echo "Variables data not existent";
	fi
	if [[ $var = "OFF" ]]; 
		then
			echo "Return debNAS is off. Exit code: 1";
			exit 1;
		else
			echo "Return debNAS is on. Exit code : 0";
			exit 0;
	fi
fi
