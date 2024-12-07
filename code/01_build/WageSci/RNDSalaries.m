% RNDSalaries    12/17/2014
%
% See NSFDoctoralSurveySalaries.xls
% NSF Survey of Doctoral Recipients
% http://www.nsf.gov/statistics/srvydoctoratework/#tabs-2&tabs-2
% Downloaded Dec 17, 2014
%
% Characteristics of Doctoral Scientists and Engineers in the US
%
%	Median Salaries for PhD Scientists and Engineers doing R&D
%
% Note: All data are nominal, but that is fine -- we are dividing Nominal R&D!

if exist('RNDSalaries.log'); delete('RNDSalaries.log'); end;
diary RNDSalaries.log;
fprintf(['RNDSalaries                 ' date]);
disp ' ';
disp ' ';
help RNDSalaries

clear all;

%	Median Salaries for PhD Scientists and Engineers doing R&D		
%			
%	All fields	Science	Engineering
data=[
1993 	60600	59000 	66900
1995 	63000 	60400	69000
1997 	68000 	65000 	75000 
1999 	70400 	68000 	80000 
2001 	78000 	74500 	90000 
2003 	85000 	82700 	95000 
2006 	90000 	86900 	99800 
2008 	100000 	90000 	109000 
2010 	100000 	100000 	111000 
2013 	105000 	100000 	115000 
];

dyears=data(:,1);
dwages=data;
dwages(:,1)=[];

[lwages,years]=interplin2(log(dwages),dyears);
wages=exp(lwages);
cshow(' ',[years wages],'%6.0f %10.0f','Year AnyField Science Eng');

disp 'Average earnings growth:'
mean(delta(log(wages)))




% Occupational Earnings for Middle-Aged Cohort of White Men. Census Data
% Occupation = Natural Science
% from ~/Work/Talent/occupation_file_chad-2015-06-16.xls via Erik Hurst
%
%  1950 appears to have an error, so don't use it.
%  Use the AvgOccIncome series

clear
censusdata=[
%Year	AvgOccIncome	Education	Wage
%1950		1102.8	3.888	0.519
1950            5400    NaN     NaN   % Chad guess based on CPI and 2% real
1960		8130.4	16.24	3.803
1970		12729.7	16.12	5.951
1980		25825.8	17.28	11.687
1990		40195.8	17.03	17.630
2000		58399.7	17.49	24.935
2010		82108.7	17.7	32.82
2015            82108.7*1.025^5  NaN NaN    
 ];

cyears=censusdata(:,1);
cwages=censusdata(:,2);


[lcwages,Cyears]=interplin2(log(cwages),cyears);
Cwages=exp(lcwages);
cshow(' ',[Cyears Cwages],'%6.0f %10.0f','Year CensusEarnings');

disp 'Average earnings growth (all years):'
mean(delta(log(Cwages)))
disp 'Average earnings growth (1993-2010):'
mean(delta(log(Cwages((1993:2010)-1949))))

YearsWR=Cyears;
WageResearch=Cwages;

save RNDSalaries YearsWR WageResearch; 
diary off;


