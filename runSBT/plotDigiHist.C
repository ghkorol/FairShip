#include <TFile.h>
#include <TH1F.h>
#include <TH2F.h>
#include <TCanvas.h>
#include <TString.h>

void plotDigiHist(TString name,int rebinX = 1,int rebinY = 1){

	gStyle->SetOptStat(10);
    
    TString inFile = "data0W.root";
    
    TString legText = "";
    
    if(inFile=="data0.root")legText = "dE > 0 MeV";
    if(inFile=="data5.root")legText = "dE > 5 MeV";
    if(inFile=="data10.root")legText = "dE > 10 MeV";
    if(inFile=="data15.root")legText = "dE > 15 MeV";
    if(inFile=="data45.root")legText = "dE > 45 MeV";
    if(inFile=="data100.root")legText = "dE > 100 MeV";
    if(inFile=="data1000.root")legText = "dE > 1000 MeV";
    
    if(inFile=="data0W.root")legText = "dE > 0 MeV, w";
    if(inFile=="data5W.root")legText = "dE > 5 MeV, w";
    if(inFile=="data10W.root")legText = "dE > 10 MeV, w";
    if(inFile=="data15W.root")legText = "dE > 15 MeV, w";
    if(inFile=="data45W.root")legText = "dE > 45 MeV, w";
    
    
    

	TFile *f = new TFile(inFile);

	TH2F * h1;// = new TH1F(“h1”,“h1 title” , 100, 0, 4);
	TH1F * h2;
	
   if(name!="h_detId"){
       
	h1 = (TH2F*)f->Get(name);
    //h1->RebinX(rebinX);
    //h1->RebinY(rebinY);
    if(name=="DigiXY" || name=="PointXY"){
        h1->GetXaxis()->SetTitle("X [cm]");
        h1->GetYaxis()->SetTitle("Y [cm]");
    }
    if(name=="DigiZY" || name=="PointZY"){
        h1->GetXaxis()->SetTitle("Z [cm]");
        h1->GetYaxis()->SetTitle("Y [cm]");
    }
    if(name=="DigiZX" || name=="PointZX"){
        h1->GetXaxis()->SetTitle("Z [cm]");
        h1->GetYaxis()->SetTitle("X [cm]");
    }
    
	TCanvas * c1 = new  TCanvas("c1","c1");
		h1->Draw("colz");
	gPad->Update();
	TPaveStats *st = (TPaveStats*)h1->FindObject("stats");
		st->SetX1NDC(0.7);
		st->SetX2NDC(0.9);
		st->SetY1NDC(0.91);
		st->SetY2NDC(0.98);
	st->Draw("same");
    
   TLegend *leg = new TLegend(0.4,0.47,0.6,0.57);
   leg->SetHeader(legText,"C"); 				// option "C" allows to center the header
   if(name=="DigiXY")leg->Draw("same");
   c1->Print(name+"-W.png");
   
   } 
   else if(name=="h_detId"){
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
        leg->Draw("same");
        
       c1->Print(name+".png");
   
    }
   
	cout << "hello!" << endl;
}
