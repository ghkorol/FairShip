# example for accessing smeared hits and fitted tracks
import ROOT,os,sys,getopt
import rootUtils as ut
import shipunit as u
from ShipGeoConfig import ConfigRegistry
from rootpyPickler import Unpickler
from decorators import *
import shipRoot_conf
shipRoot_conf.configure()

PDG = ROOT.TDatabasePDG.Instance()
inputFile  = None
geoFile    = None
nEvents    = 9999999
try:
        opts, args = getopt.getopt(sys.argv[1:], "n:f:g:A:Y:i", ["nEvents=","geoFile="])
except getopt.GetoptError:
        # print help information and exit:
        print ' enter file name'
        sys.exit()
for o, a in opts:
        if o in ("-f",):
            inputFile = a
        if o in ("-g", "--geoFile",):
            geoFile = a
        if o in ("-n", "--nEvents=",):
            nEvents = int(a)
eosship = ROOT.gSystem.Getenv("EOSSHIP")
if not inputFile.find(',')<0 :  
  sTree = ROOT.TChain("cbmsim")
  for x in inputFile.split(','):
   if x[0:4] == "/eos":
    sTree.AddFile(eosship+x)
   else: sTree.AddFile(x)
elif inputFile[0:4] == "/eos":
  eospath = eosship+inputFile
  f = ROOT.TFile.Open(eospath)
  sTree = f.cbmsim
else:
  f = ROOT.TFile(inputFile)
  sTree = f.cbmsim

# try to figure out which ecal geo to load
if not geoFile:
 geoFile = inputFile.replace('ship.','geofile_full.').replace('_rec.','.')
if geoFile[0:4] == "/eos":
  eospath = eosship+geoFile
  fgeo = ROOT.TFile.Open(eospath)
else:  
  fgeo = ROOT.TFile(geoFile)

sGeo   = fgeo.FAIRGeom

import random

h_DigiX = ROOT.TH1F("DigiX","DigiX",1000,-300,300)
h_DigiY = ROOT.TH1F("DigiY","DigiY",1000,-600,600)
h_DigiZ = ROOT.TH1F("DigiZ","DigiZ",1000,-3000,3000)
h_DigiXY = ROOT.TH2F("DigiXY","Digi hits in XY",40,-300,300,40,-600,600)
h_DigiZX = ROOT.TH2F("DigiZX","Digi hits in ZX",80,-3000,3000,40,-300,300)
h_DigiZY = ROOT.TH2F("DigiZY","Digi hits in ZY",80,-3000,3000,40,-600,600)

h_detId = ROOT.TH1F("h_detId","h_detId",500000,100000,600000)

h_w = ROOT.TH1F("w","w",1000,0,10000)

h_PointX = ROOT.TH1F("PointX","PointX",1000,-300,300)
h_PointY = ROOT.TH1F("PointY","PointY",1000,-600,600)
h_PointZ = ROOT.TH1F("PointZ","PointZ",1000,-3000,3000)
h_PointXY = ROOT.TH2F("PointXY","Point hits in XY",40,-300,300,40,-600,600)
h_PointZX = ROOT.TH2F("PointZX","Point hits in ZX",80,-3000,3000,40,-300,300)
h_PointZY = ROOT.TH2F("PointZY","Point hits in ZY",80,-3000,3000,40,-600,600)



# start event loop
def myEventLoop(n):
  rc = sTree.GetEntry(n)
  for digi in sTree.Digi_SBTHits:
   if digi.isValid():
    w=digi.GetWeight()
    h_w.Fill(w)
    h_detId.Fill(digi.GetDetectorID(),w)
    h_DigiX.Fill(digi.GetX(),w)
    h_DigiY.Fill(digi.GetY(),w)
    h_DigiZ.Fill(digi.GetZ(),w)
    h_DigiXY.Fill(digi.GetX(),digi.GetY(),w) 
    h_DigiZX.Fill(digi.GetZ(),digi.GetX(),w)
    h_DigiZY.Fill(digi.GetZ(),digi.GetY(),w)
  for aMCPoint in sTree.vetoPoint:
   h_PointX.Fill(aMCPoint.GetX())
   h_PointY.Fill(aMCPoint.GetY())
   h_PointZ.Fill(aMCPoint.GetZ())
   h_PointXY.Fill(aMCPoint.GetX(),aMCPoint.GetY()) 
   h_PointZX.Fill(aMCPoint.GetZ(),aMCPoint.GetX())
   h_PointZY.Fill(aMCPoint.GetZ(),aMCPoint.GetY())
  
   
# ---
nEvents = min(sTree.GetEntries(),nEvents)

for n in range(nEvents): 
 myEventLoop(n)

# output histograms
ROOT.gROOT.cd()

from ROOT import TFile
fSave = TFile( 'sbt.root', 'recreate' )
h_detId.SetDirectory(fSave)
h_DigiX.SetDirectory(fSave)
h_DigiY.SetDirectory(fSave)
h_DigiZ.SetDirectory(fSave)
h_DigiXY.SetDirectory(fSave)
h_DigiZX.SetDirectory(fSave)
h_DigiZY.SetDirectory(fSave)

h_PointX.SetDirectory(fSave)
h_PointY.SetDirectory(fSave)
h_PointZ.SetDirectory(fSave)
h_PointXY.SetDirectory(fSave)
h_PointZX.SetDirectory(fSave)
h_PointZY.SetDirectory(fSave)
h_w.SetDirectory(fSave)

fSave.Write()
fSave.Close()

