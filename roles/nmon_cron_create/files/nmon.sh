#!/usr/bin/bash

###########
# Variable
###########
export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin

LOG=/var/log/nmon
mkdir -p ${LOG}
DATE=`/usr/bin/date +%Y%m%d`
HOST=`/usr/bin/hostname`
NMON=/usr/bin/nmon
FILE=${LOG}/${HOST}_${DATE}.nmon

# Daily Interval(Sec) : (10:8640, 30:2880, 60:1440)
INTERVAL=60
COUNT=1440

###########
# kill nmon process
###########
echo "kill nmon process"
for i in `ps -ef |grep "/usr/bin/nmon -F /var/log/nmon/${HOST}" |egrep -v grep |awk '{print $2}'`
do
  if [ -n $i ]
  then
    kill -9 $i
  else
    echo "nmon process no running"
  fi
sleep 5
done

###########
# nmon command
###########
echo "nmon execute"
${NMON} -F ${FILE} -s ${INTERVAL} -c ${COUNT}  -T
###########
# LOG Clean
###########
echo "nmon log clean"
cd ${LOG}
find . -name "*.nmon" -mtime +7 -exec gzip {} \;
find . -name "*.nmon" -mtime +14 -exec rm -f {} \;
