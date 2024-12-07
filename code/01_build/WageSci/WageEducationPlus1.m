% WageEducationPlus1.m
%
%   Add 1% to WageEducation.m for robustness
%
%   Note well: Any wage program should save the following three variables
%     WageYears= e.g. (1929:2015)'
%     WageScientist=NominalGDPperPerson;
%     WageNotes={'Currently using Nominal GDP per Person from NIPA for the wage deflator'}
%   into the .mat file WageScientistData.mat
%
%   That way we can easily change the wage deflator by just running a different wage program
%   and then rerunning the idea TFP programs.

clear;
diarychad('WageEducationPlus1');

% Run the basic WageEducation program first
% to get the benchmark series that we "add 1%" to.
WageEducation; 


% lnwage has already interpolated log-linearly to get missing years.
%[lnwage,years]=interplin2(log(edwage),edyrs);
T=length(lnwage);
t=(0:T-1)';
WageScientist=exp(lnwage+.01*t);  % Add 1 percent per year page growth
WageYears=years;
WageNotes={
    'WageEducationPlus1: Adds 1% annual wage growth to WageEducation.m'
    'Currently using Mean Personal Income for Males with 4+ years of college'};
disp ' ';
disp(WageNotes);
disp 'Earnings Data (college grads)';
cshow(' ',[WageYears WageScientist],'%8.0f');


save WageScientistData WageYears WageScientist WageNotes;
diary off;