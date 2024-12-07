% MasterCompustat   6/17/16
%
%  Master file for executing the Compustat programs.
%  Hint: to keep "figure(.)" from grabbing focus, use "sfigure(.)".

% Read the raw data
% This first program takes about 10 minutes to run. The rest are faster...
clear 
global CaseName MasterCase;
CompustatRead

% % Sandbox
%RequireAllDecadesPosGrowth=-1; % Robust 3: Keep *all* decades, even if negative growth!
%MinimumGrowthRate=0.01;  % Replace all growth rates below 0.01 with 0.01 (to fix negatives)
%WindsorizeTop=1;         % Find the percentile for MinimumGrowthRate and windsorize at top as well.
% clear; global CaseName;
% CaseName='Sandbox';
% SetParameters;
% OutputMeasure='Sales';
% DHSGrowthRates=1;
% CompustatIdeaPF;
% abc


% Sales
clear; global CaseName;
CaseName='Sales';
SetParameters;
OutputMeasure='Sales';
CompustatIdeaPF;


% Market Cap
clear; global CaseName;
CaseName='MktCap';
SetParameters;
OutputMeasure='MktCap';
DotComCorrection=1;
CompustatIdeaPF;

% Employment
clear; global CaseName;
CaseName='Employment';
SetParameters;
OutputMeasure='Emp';
CompustatIdeaPF;

% Revenue Labor Productivity (RLP)
clear; global CaseName;
CaseName='RLP';
SetParameters;
OutputMeasure='RLP';
CompustatIdeaPF;

% RLP MinGrowth1
clear; global CaseName;
CaseName='RLPMinGrowth1';
SetParameters;
MinimumGrowthRate=0.01;  % Replace all growth rates below 0.01 with 0.01 (to fix negatives)
OutputMeasure='RLP';
CompustatIdeaPF;


% Median instead of Mean IdeaGrowth
clear; global CaseName;
SetParameters;
CaseName='MedianIdeaGrowth';
DotComCorrection=1;
IdeaGrowthApproach='Median';
CompustatIdeaPF;


% NoDotComCor = No correction for the Dot Com Bubble, 1995-2002
clear; global CaseName;
SetParameters;
CaseName='NoDotComCor';
OutputMeasure='MktCap';
DotComCorrection=0;
CompustatIdeaPF;


% UnWeighted = Equal weights across observations instead of by Scientists
clear; global CaseName;
SetParameters;
CaseName='UnWeighted';
WeightingByScientists=0;
CompustatIdeaPF;

% Robustness Sample 1: Require Increasing Scientists ==> smaller sample
clear; global CaseName;
SetParameters;
CaseName='Robust1';
SampleFrame='Robust1';
RequireIncreasingScientists=1; 
CompustatIdeaPF;

% Robustness Sample 2: Require *every* decade to have positive IdeaGrowth ==> Smaller sample
clear; global CaseName;
SetParameters
CaseName='Robust2';
SampleFrame='Robust2';
RequireAllDecadesPosGrowth=1; 
CompustatIdeaPF;


% MinGrowth1
clear; global CaseName;
CaseName='MinGrowth1';
SetParameters;
MinimumGrowthRate=0.01;  % Replace all growth rates below 0.01 with 0.01 (to fix negatives)
CompustatIdeaPF;

% MinGrowth5
clear; global CaseName;
CaseName='MinGrowth5';
SetParameters;
MinimumGrowthRate=0.05;  % Replace all growth rates below 0.05 with 0.05 (to fix negatives)
CompustatIdeaPF;

% MinGrowth1emp
clear; global CaseName;
CaseName='MinGrowth1emp';
SetParameters;
OutputMeasure='Emp';
MinimumGrowthRate=0.01;  % Replace all growth rates below 0.01 with 0.01 (to fix negatives)
CompustatIdeaPF;

% Windsor1
clear; global CaseName;
CaseName='Windsor1';
SetParameters;
OutputMeasure='Sales';
MinimumGrowthRate=0.01;  % Replace all growth rates below 0.01 with 0.01 (to fix negatives)
WindsorizeTop=1;         % Find the percentile for MinimumGrowthRate and windsorize at top as well.
CompustatIdeaPF;

% Windsor1emp
clear; global CaseName;
CaseName='Windsor1emp';
SetParameters;
OutputMeasure='Emp';
MinimumGrowthRate=0.01;  % Replace all growth rates below 0.01 with 0.01 (to fix negatives)
WindsorizeTop=1;         % Find the percentile for MinimumGrowthRate and windsorize at top as well.
CompustatIdeaPF;

% Windsor1mcap
clear; global CaseName;
CaseName='Windsor1mcap';
SetParameters;
OutputMeasure='MktCap';
MinimumGrowthRate=0.01;  % Replace all growth rates below 0.01 with 0.01 (to fix negatives)
WindsorizeTop=1;         % Find the percentile for MinimumGrowthRate and windsorize at top as well.
CompustatIdeaPF;

% DHSGrowthRates
clear; global CaseName;
CaseName='DHSGrowth';
SetParameters;
OutputMeasure='Sales';
DHSGrowthRates=1;
CompustatIdeaPF;

% abc




