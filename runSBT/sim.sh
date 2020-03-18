#!/bin/bash
ClusterId=$1
ProcId=$2
inFile=$3
startEvent=$4
nEvents=$5

#OUTPUTDIR=/afs/cern.ch/work/i/ikorol/HTCondor/output-sim
OUTPUTDIR=/eos/experiment/ship/user/korol/sbt/output-sim

source /cvmfs/ship.cern.ch/SHiP-2020/latest/setUp.sh
export ALIBUILD_WORK_DIR=/afs/cern.ch/work/i/ikorol/sbt-geometry/sw
#eval `alienv load FairShip/latest`
#eval `alienv load FairShip/latest-master-fairship`
source /afs/cern.ch/work/i/ikorol/sbt-geometry/config.sh



python $FAIRSHIP/macro/run_simScript.py --nEvents $nEvents --firstEvent $startEvent -f $inFile --MuonBack
#python $FAIRSHIP/macro/run_simScript.py --nEvents 1000 --firstEvent $startEvent -f $inFile --MuonBack
cp ship.conical.MuonBack-TGeant4.root $OUTPUTDIR/$ClusterId.$ProcId.root

