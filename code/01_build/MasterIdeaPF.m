% MasterIdeaPF.m
%
%  Master program to generate the results in
%  "Are Ideas Getting Harder to Find?"

clear all; global MasterCase MasterNote Lambda StopForFigLabels;

%path('ChadMatlab:',path) % For replication; use 'pathreset.m' to clean path
% Make sure all relevant files are in path
curpath=path;
if isempty(strfind(curpath,'ChadMatlab')); % | isempty(strfind(curpath,'Work/procs'));
    if exist('ChadMatlab')==7; 
        curdir=pwd;
        path([curdir '/ChadMatlab'],path); 
    end; 
end;

tic;

% MainResults
MasterCase='Main';
MasterNote='Main Benchmark Case';
Lambda=1;
StopForFigLabels=0; % Set to 1 to pause so that fig labels can be adjusted when necessary
cd WageSci; WageEducation; cd .. % The wage series for deflating R&D spending
cd Aggregate; AggregateBLSIPP; AggregateBLS_SciEng; cd ..
cd MooresLaw; IntelGraph; SemiconductorTFP; cd ..
cd Seeds; SeedYields; AgIdeaPF; cd ..    
cd Pharma; NMEGraph; cd ..
cd Mortality; LifeExpectancy; Cancer; BreastCancer; HeartDisease; cd ..
cd Compustat; MasterCompustat; cd .. 
chadtimer    
    
% Robustness: Use nominal GDP per person as the wage deflator
%   as an alternative wage series
MasterCase='WageGDP';
MasterNote='Wage deflator is nominal GDP per person';
Lambda=1;
StopForFigLabels=0; % Set to 1 to pause so that fig labels can be adjusted when necessary
cd WageSci; WageNominalGDP; cd .. % The wage series for deflating R&D spending
cd Aggregate; AggregateBLSIPP; AggregateBLS_SciEng; cd ..
cd MooresLaw; IntelGraph; SemiconductorTFP; cd ..
cd Seeds; SeedYields; AgIdeaPF; cd ..    
cd Pharma; NMEGraph; cd ..
cd Mortality; Cancer; BreastCancer; HeartDisease; cd ..
cd Compustat; MasterCompustat; cd .. 
chadtimer    
    
% Robustness: Use WageEducation "plus 1% per year" for wage deflator
%   as a possible correction to selection bias in the quality of educated workers
MasterCase='WagePlus1';
MasterNote='Wage deflator plus 1 percent annually for selection';
Lambda=1;
StopForFigLabels=0; % Set to 1 to pause so that fig labels can be adjusted when necessary
cd WageSci; WageEducationPlus1; cd .. % The wage series for deflating R&D spending
cd Aggregate; AggregateBLSIPP; AggregateBLS_SciEng; cd ..
cd MooresLaw; IntelGraph; SemiconductorTFP; cd ..
cd Seeds; SeedYields; AgIdeaPF; cd ..    
cd Pharma; NMEGraph; cd ..
cd Mortality; Cancer; BreastCancer; HeartDisease; cd ..
cd Compustat; MasterCompustat; cd ..     
chadtimer    
    
% Lambda = 3/4 Robustness check    
%  Reports Scientists^Lambda everwhere
MasterCase='Lambda';
MasterNote='Robustness check -- diminishing returns to R&D: reports S^Lambda everywhere';
Lambda=3/4;
StopForFigLabels=0; % Set to 1 to pause so that fig labels can be adjusted when necessary
cd WageSci; WageEducation; cd .. % The wage series for deflating R&D spending
cd Aggregate; AggregateBLSIPP; cd ..
cd MooresLaw; IntelGraph; SemiconductorTFP; cd ..
cd Seeds; SeedYields; AgIdeaPF; cd ..    
cd Pharma; NMEGraph; cd ..
cd Mortality; Cancer; BreastCancer; HeartDisease; cd ..
cd Compustat; MasterCompustat; cd .. 
chadtimer    
