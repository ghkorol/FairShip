#!/bin/bash
ClusterId=$1
ProcId=$2
inFile=$3

#OUTPUTDIR=/afs/cern.ch/work/i/ikorol/HTCondor/output-sim
#OUTPUTDIR=/eos/experiment/ship/user/korol/sbt/output-sim
OUTPUTDIR=/eos/experiment/ship/user/korol/sbt/output-reco
#OUTPUTDIR=/eos/home-i/ikorol/sbt/output-reco



source /cvmfs/ship.cern.ch/SHiP-2020/latest/setUp.sh
export ALIBUILD_WORK_DIR=/afs/cern.ch/work/i/ikorol/sbt-geometry/sw
#eval `alienv load FairShip/latest`
#eval `alienv load FairShip/latest-master-fairship`
source /afs/cern.ch/work/i/ikorol/sbt-geometry/config.sh

INPUTDIR=/eos/experiment/ship/user/korol/sbt/output-sim


python $FAIRSHIP/macro/ShipReco.py -f $INPUTDIR/$inFile -g /afs/cern.ch/work/i/ikorol/HTCondor/geoFile/geofile_full.conical.MuonBack-TGeant4.root
#python $FAIRSHIP/macro/run_simScript.py --nEvents 1000 --firstEvent $startEvent -f $inFile --MuonBack
new=`echo $inFile | sed 's/.root/_rec.root/'`
mv $new $OUTPUTDIR/

