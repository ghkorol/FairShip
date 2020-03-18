#!/bin/bash
ClusterId=$1
ProcId=$2
inFile=$3

OUTPUTDIR=/eos/experiment/ship/user/korol/sbt/output-ana
#OUTPUTDIR=/eos/home-i/ikorol/sbt/output-ana


source /cvmfs/ship.cern.ch/SHiP-2020/latest/setUp.sh
export ALIBUILD_WORK_DIR=/afs/cern.ch/work/i/ikorol/sbt-geometry/sw
source /afs/cern.ch/work/i/ikorol/sbt-geometry/config.sh

#INPUTDIR=/eos/home-i/ikorol/sbt/output-reco
INPUTDIR=/eos/experiment/ship/user/korol/sbt/output-reco



python /afs/cern.ch/work/i/ikorol/sbt-geometry/VetoAna2.py -f $INPUTDIR/$inFile -g /afs/cern.ch/work/i/ikorol/HTCondor/geoFile/geofile_full.conical.MuonBack-TGeant4.root
#python /afs/cern.ch/work/i/ikorol/sbt-geometry/FairShip/VetoAna2.py -f $INPUTDIR/$inFile -g /afs/cern.ch/work/i/ikorol/HTCondor/geoFile/geofile_full.conical.MuonBack-TGeant4.root

#new=`echo $inFile | sed 's/.root/_rec.root/'`
cp sbt.root $OUTPUTDIR/$ProcId.sbt.root

