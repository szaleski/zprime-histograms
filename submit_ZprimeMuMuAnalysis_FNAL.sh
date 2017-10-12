#!/bin/bash

echo "Processing on " `hostname` "at " `date` 

echo "Running ZprimeMuMu Analysis with executables RunZprimeMuMuAnalysis"
source /cvmfs/cms.cern.ch/cmsset_default.sh 
export LD_LIBRARY_PATH=lib:$LD_LIBRARY_PATH
export PATH=path:$PATH

echo "PATH ${PATH}"
echo "LD_LIBRARY_PATH ${LD_LIBRARY_PATH}"

echo "Creating output location /store/user/${USER}/ZprimeAnalysis/"
eosmkdir -p /store/user/${USER}/ZprimeAnalysis/jobdir
eosmkdir -p /store/user/${USER}/ZprimeAnalysis/histodir

if [ -d "$_CONDOR_SCRATCH_DIR/" ]; then
    workdir=`echo $_CONDOR_SCRATCH_DIR/`;
    cd ${workdir};
fi


savedir=`echo root://cmseos.fnal.gov///store/user/${USER}/ZprimeAnalysis/histodir`

echo "Working dir is $workdir"
echo "Saving dir is $savedir"

echo "Compiling the macros"
bash compileZprimeMuMuAnalysis.sh

./RunZprimeMuMuAnalysis which sig_input.txt 1 bkg_input.txt 1 data_input.txt 1 site year mc >& ${workdir}/RunZprimeMuMuAnalysis.log 
xrdcp --force ${workdir}/RunZprimeMuMuAnalysis.log root://cmseos.fnal.gov///store/user/${USER}/ZprimeAnalysis/jobdir/.
xrdcp --force ${workdir}/CMSSW803-Analyse_ZprimeToMuMu_13TeV.root     ${savedir}/output.root
xrdcp --force ${workdir}/CMSSW803-Analyse_ZprimeToMuMu_13TeV_cand.txt ${savedir}/output_cand.txt