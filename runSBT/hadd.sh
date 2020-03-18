#!/bin/bash

#for a in `ls|grep root`; do 
#	hadd -f -k temp1.o temp.o $a
#	mv temp1.o temp.o
#done
#mv temp.o haddall.root



rm data.root
i=0
j=500
for a in `ls|grep "root"`; do
if [ $i -lt $j ] 
then
list=$list" $a"
else
hadd $i"temp.root" $list
list="$a"
j=$[$j+500]
fi
i=$[$i+1]
done
hadd $i"temp.root" $list
#echo $list
hadd data.root *temp.root
rm *temp.root
