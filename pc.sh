#!/bin/bash
if [ $@ == "start" ];
then
	echo "PC Start is triggered";
	sudo etherwake 4C:CC:6A:69:D6:F1
	echo "ON" > /home/fauxmo/pc.data
fi
	if [ $@ == "stop" ];
then
	echo "PC Stop is triggered";
	net rpc shutdown -I 192.168.42.143 -U
	echo "OFF" > /home/fauxmo/pc.data
fi
if [ $@ == "status" ];
then
	if [ -e "/home/fauxmo/pc.data" ]; then
		var=`cat /home/fauxmo/pc.data`;
	else
		echo "Variables data not existent";
	fi
	if [[ $var = "OFF" ]]; then
		echo "Return PC is off. Exit code: 1";
		exit 1;
	else
		echo "Return PC is on. Exit code : 0";
		exit 0;
	fi
fi
