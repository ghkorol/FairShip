#!/bin/bash

date >> getEntriesForAllFiles.out
for a in /eos/experiment/ship/data/Mbias/background-prod-2018/pythia8_Geant4_10.0_withCharmandBeauty{0..66000..1000}_mu.root;do
    ./getEntries $a >> getEntriesForAllFiles.out
done

