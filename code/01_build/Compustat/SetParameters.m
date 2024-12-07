% SetParameters.m   for Compustat

WeightingByScientists=1;       % Default is to weight
DotComCorrection=0;            % Default is NOT to smooth out the stock market bubble 1995-2002
RequireAllDecadesPosGrowth=0;  % Default is *not* to require *every* decade to have positive MktCapGrowth
RequireIncreasingScientists=0; % Default is *not* to only look at observations where Scientists increase between decades
IdeaGrowthApproach='Mean';     % Default uses average growth in market cap; alternative is median.
MinimumGrowthRate=NaN;         % If not NaN, replace all growth rates below (e.g.) 0.01 with 0.01 (to fix negatives)
WindsorizeTop=0;               % Find the percentile for MinimumGrowthRate and windsorize at top as well?
DHSGrowthRates=0;              % If 1, use DHS growth rate for iTFP = (xt-xt-1)/(0.5*xt +0.5*xt-1)

load ../WageSci/WageScientistData      % Loads whatever wage deflator we are using as default.
CompuStatYears=(1980:2015)';   % Years for RND
WageSci=WageScientist(CompuStatYears-WageYears(1)+1);
WageNotes

SampleFrame='Baseline';
OutputMeasure='Sales';  % Options are {'Sales', 'MktCap', 'Emp'}