#!/bin/bash
IP=`wget -O - -q http://checkip.dyndns.org/index.html | cut -d ' ' -f 6 | cut -d '<' -f 1`
IP2=`lynx -dump http://www.whatismyip.com | grep -i "Your IP Address Is" | awk '{ print $5; }'`

OLDIP=`cat /etc/ip/mon_ip`
if [ $IP != $OLDIP ]
 then
    echo "$IP ou $IP2 est ta nouvelle ip. Ton ancienne etait $OLDIP" | msmtp foobar@mail.com
    wget http://checkip.dyndns.org/ -O - -o /dev/null | cut -d: -f 2 | cut -d\< -f 1 > /etc/ip/mon_ip
fi
