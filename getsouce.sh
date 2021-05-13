#! /bin/bash

#dpkg -l |awk '{print $2}' >deb.lis

SL=source-test.list
FL=faile.list
touch $SL
while read line ;do
	source_name=$(apt-cache show $line |grep -i "source:" | head -1| awk '{print $2}')
	if [ "x$source_name" = "x" ];then
		if grep -wqs "^$line$" $SL;then
			continue
		else
			echo "$line" >>$SL
		fi
	else
		if grep -wqs "^$source_name$" $SL; then
		 	continue
		else
			echo $source_name >> $SL
		fi
	fi
done < $1
