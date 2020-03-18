#include <TFile.h>
#include <TH1F.h>
#include <TH2F.h>
#include <TCanvas.h>
#include <TString.h>

void plotDigiHistW(TString name,int rebinX = 1,int rebinY = 1){

	gStyle->SetOptStat(10);
    
    TString inFile = "OLDdata45W.root";
    inFile = "data15W.root";
    inFile = "data10W.root";
    inFile = "data5W.root";
    inFile = "data0W.root";
    
    
    TString legText = "";
    
    if(inFile=="data0W.root")legText = "dE > 0 MeV";
    if(inFile=="data5W.root")legText = "dE > 5 MeV";
    if(inFile=="data10W.root")legText = "dE > 10 MeV";
    if(inFile=="data15W.root")legText = "dE > 15 MeV";
    if(inFile=="OLDdata45W.root")legText = "dE > 45 MeV";
    if(inFile=="data100.root")legText = "dE > 100 MeV";
    if(inFile=="data1000.root")legText = "dE > 1000 MeV";

	TFile *f = new TFile(inFile);

	TH2F * h1;// = new TH1F(“h1”,“h1 title” , 100, 0, 4);
	TH1F * h2;
	
       h2 = (TH1F*)f->Get(name);
       h2->GetXaxis()->SetTitle("Detector ID");
        h2->GetYaxis()->SetTitle("N Digi Hits / Spill");
    
       	TCanvas * c1 = new  TCanvas("c1","c1");
        c1->SetLogy();
        //h2->SetLineWidth(2);
		h2->Draw("hist");
        
        int maxval =  h2->GetBinContent(h2->GetMaximumBin());
            
        TLegend *leg = new TLegend(0.4,0.77,0.7,0.87);
        leg->SetHeader(Form("max: %d", maxval),"C");
        leg->AddEntry("",legText,"");
        leg->Draw("same");
        
       c1->Print(name+".png");
   
   
	cout << "hello!" << endl;
}
