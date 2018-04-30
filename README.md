# zprime-histograms
Migrate the zprime histogramming macros to github
in e.g. sig_input_lam16_2e.txt
<DAS PDSName, no. events requested, filter eff. number of events generated, XS [pb] > loads into loopsubmit_*.sh

e.g. bash loopsubmit_sig.sh sig NO 2mu FNAL Mu
e.g. bash loopsubmit_data.sh data 2016 NO FNAL Mu
e.g. bash loopsubmit_bkg.sh bgk NO Spring16 FNAL Mu

To run plot stacking:
root -l
.L PlotStack.C
.x PlotStack()
