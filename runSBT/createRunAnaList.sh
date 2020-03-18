#!/bin/bash

#./createRunAnaList.sh > queue_list_ana.txt

inPath=/eos/experiment/ship/user/korol/sbt/output-reco

for a in `ls $inPath`
	do
		echo $a
	done

