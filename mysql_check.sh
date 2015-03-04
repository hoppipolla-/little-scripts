#!/bin/sh
#shell to connect mysql client to query sql
mysql_user=a
mysql_passwd=b
mysql_db=c

declare -i current_count
declare -i last_count
mysql -u $mysql_user -p$mysql_passwd -D $mysql_db -e "select count(*) from ofUser;" >/tmp/tmpfile1

current_count=`grep ^[0-9] /tmp/tmpfile1`
last_count=`grep ^[0-9] /tmp/tmpfile`
diff_count=`expr $current_count - $last_count`
echo $current_count $last_count $diff_count >> /opt/logs/check.log

if [ $diff_count -gt 1000 ]
then
        echo `date`"check user create sucessfully" >> /opt/logs/check.log
else
        echo `date`"check user create error!" >> /opt/logs/check.log
fi
mv /tmp/tmpfile1 /tmp/tmpfile
