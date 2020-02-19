#!/bin/bash

if [ $@ == "start" ]; then
	echo "true" > /home/fauxmo/speedtest_allowance;
	exit 0;
fi
if [ $@ == "stop" ]; then
	echo "false" > /home/fauxmo/speedtest_allowance;
	exit 0;
fi
allowancebit=`cat /home/fauxmo/speedtest_allowance`;
echo "allowancebit is $allowancebit";
if [ $@ == "status" ]; then
	if [ $allowancebit == "true" ]; then
		echo "Sending Speedtest is on. exit code 0";
		exit 0;
	fi
	if [ $allowancebit == "false" ]; then
		echo "Sending Speedtest is off. exit code 1";
		exit 1;
	fi
fi
if [ $allowancebit == "true" ] && [ $@ == "measure" ]; then
echo "measure is started";
raw=$(/usr/local/bin/speedtest --csv | cut -d, -f7-8)
downloadbit=$(echo $raw | cut -d, -f1 | cut -d. -f1)
uploadbit=$(echo $raw | cut -d, -f2 | cut -d. -f1)

uploadmbyte=$(($uploadbit/800000))
downloadmbyte=$(($downloadbit/800000))
echo `date +"%H-%M-%S"`
/usr/bin/zabbix_sender -k trap.upload -o $uploadmbyte -z 116.203.4.140 -s "naski.org"
/usr/bin/zabbix_sender -k trap.download -o $downloadmbyte -z 116.203.4.140 -s "naski.org"
fi
