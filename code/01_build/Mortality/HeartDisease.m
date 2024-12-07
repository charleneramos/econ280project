% HeartDisease.m   
%
% Idea TFP for HeartDisease (all types) mortality
%
%  See HeartDisease/Mortality1968-2015_65-74.txt for mortality rate data from CDC Wonder.
%  These are for 65-74 year olds.

clear;
global MasterCase Lambda StopForFigLabels;
CaseName='HeartDisease';
diarychad(CaseName,MasterCase);
run ../ShowMasterParameters
if strcmp(MasterCase,'Main')~=1; CaseName=[CaseName '_' MasterCase]; end;
definecolors;


% Crude death rate, ages 65-74 per 100,000
cmortdata=[ 
      % Year   Death Rate
       	1968	1632.91
       	1969	1588.35
       	1970	1558.22
       	1971	1509.49
       	1972	1509.84
       	1973	1458.39
       	1974	1396.58
       	1975	1319.73
       	1976	1283.04
       	1977	1245.76
       	1978	1226.28
       	1979	1199.76
       	1980	1218.61
       	1981	1176.54
       	1982	1156.21
       	1983	1145.52
       	1984	1109.80
       	1985	1089.84
       	1986	1054.85
       	1987	1021.84
       	1988	999.22 
       	1989	928.05 
       	1990	894.26 
       	1991	871.33 
       	1992	846.74 
       	1993	845.80 
       	1994	814.00 
       	1995	795.38 
       	1996	769.82 
       	1997	746.18 
       	1998	728.56 
       	1999	701.74 
       	2000	665.57 
       	2001	632.60 
       	2002	612.05 
       	2003	579.77 
       	2004	535.68 
       	2005	512.29 
       	2006	483.01 
       	2007	454.80 
       	2008	441.44 
       	2009	422.76 
       	2010	409.20 
       	2011	399.03 
       	2012	388.33 
       	2013	390.34 
       	2014	385.19 
%       	2015	389.48 
      ];

yrs=cmortdata(:,1);
cmort=cmortdata(:,2);



% Publications and Clinical Trials for "Heart Diseases"
% Uses python pubmedscrapernoprog.py "Neoplasms" --start 1961 --end 2015 --title allcancers
%  -- This is a "flow" number, not a stock...
% See pubmedscraper.readme for details and pubmed_results.xls for all results.

effortdata=[
%Year	Publications	Trials
1961	4020	NaN %0
1962	4704	NaN %0
1963	6111	NaN %0
1964	7719	2
1965	6765	57
1966	6914	101
1967	7982	95
1968	8595	128
1969	8969	144
1970	8736	140
1971	9509	141
1972	9967	176
1973	10427	267
1974	10054	212
1975	10630	268
1976	10299	250
1977	10531	237
1978	10726	295
1979	10970	293
1980	11087	332
1981	11631	368
1982	12087	416
1983	12930	489
1984	13596	565
1985	13939	675
1986	14029	712
1987	14519	719
1988	14691	750
1989	15717	829
1990	16223	1036
1991	16289	1018
1992	16402	912
1993	16788	908
1994	16355	1367
1995	17084	1535
1996	17359	1271
1997	17825	1528
1998	18517	1528
1999	19510	1702
2000	20752	1870
2001	21319	1569
2002	22336	1659
2003	24370	2019
2004	25712	2022
2005	28534	2121
2006	30697	2118
2007	32741	2299
2008	33717	2217
2009	35095	2295
2010	36339	2233
2011	38591	2412
2012	40231	2622
2013	43592	3102
%2014	43632	2948
%2015	42519	2727
];

pubyrs=effortdata(:,1);
Publications=effortdata(:,2);
Trials=effortdata(:,3);
PubScaleString = '25 100 400 1600 6400 25600 102400';
TFPScaleString = '1 2 4 8 16 32';

FiveYearSurvRate=[]; % Do not use this for Heart Disease. Age 65-74
MortalityRate_uncond=cmort; % Age 65-74

% Adjust for Lambda
Publications=Publications.^Lambda;
Trials=Trials.^Lambda;

% IDEA TFP and Plots -- call the function
TextLocations=[1995 1968; 1980 1975]; % Text string locations for 3 key figures
mortality(CaseName,FiveYearSurvRate,MortalityRate_uncond,yrs,Publications,Trials,pubyrs,PubScaleString,TFPScaleString,TextLocations,StopForFigLabels);


diary off;
