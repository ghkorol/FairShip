#!/bin/bash

#./updateRunAnaList.sh > queue_list_anaU.txt 

prefix=`head -1 queue_list_ana.txt | awk -F "." '{print $1}'`
prefixAna=`ls /eos/experiment/ship/user/korol/sbt/output-ana/ | head -1 | awk -F "." '{print $1}'`
#echo $prefixAna

#for val in {0..8147}
for val in {0..582}
do
	if [ ! -f /eos/experiment/ship/user/korol/sbt/output-ana/${prefixAna}.${val}.sbt.root ]; then
               #echo $prefix.$a "File not found!"
               #echo "File not found: "  $prefix.${val}_rec.root
	       awk 'NR == n' n=$((val+1)) queue_list_ana.txt
	fi
done

#echo $prefix

#for a in `cat queue_list_ana.txt | awk  -F "." '{print $2}' | awk  -F "_" '{print $1}'`
#do
#	if [ ! -f /eos/experiment/ship/user/korol/sbt/output-ana/${prefixAna}.${a}.sbt.root ]; then
#   		#echo $prefix.$a "File not found!"
#		echo $prefix.${a}_rec.root
#	fi
#done		

