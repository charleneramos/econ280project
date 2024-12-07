% Cancer.m   
%
% Idea TFP for Cancer (all types) mortality
%
% Note: For Breast Cancer, I used the U.S. mortality rate data. I was surprised that
%  the death rate from breast cancer *rose* betwen 1975 and the early 1990s. It turns out the
%  same thing is true for All Cancer mortality as well. My interpretation of this is that 
%  mortality from other causes fell enough that now people are living long enough to actually *get* cancer,
%  whereas before they were not. So # of deaths could rise even though the mortality rate *conditional* on 
%  getting cancer could fall.
%
%  Now I'm using 5-year survival rates to measure "Probabilit of Death conditional on getting Cancer"
%  and using that as the death rate to plug into our calculation. Should be better, I think...

clear;
global MasterCase Lambda StopForFigLabels;
CaseName='Cancer';
diarychad(CaseName,MasterCase);
run ../ShowMasterParameters
if strcmp(MasterCase,'Main')~=1; CaseName=[CaseName '_' MasterCase]; end;
definecolors;


% 5-Year Relative Survival By Year Dx
%  All Cancer Sites
%  All Ages  White  Both Sexes
% 1975-2012 
% http://seer.cancer.gov/faststats/selections.php
% Downloaded 11/13/15
cdata=[
%Year	All Ages   50+      65+
1975	49.6	46.6	43.2
1976	49.9	46.9	43.4
1977	49.8	46.7	43.4
1978	50.1	47.0	44.5
1979	49.9	46.9	44.0
1980	49.9	46.8	44.4
1981	50.9	47.7	45.0
1982	50.8	47.6	45.0
1983	52.0	49.0	46.8
1984	52.4	49.4	47.5
1985	53.7	50.9	49.3
1986	54.6	51.8	50.0
1987	56.1	53.6	52.2
1988	56.9	54.7	53.5
1989	57.0	54.6	53.5
1990	59.2	57.0	56.3
1991	61.5	59.9	59.4
1992	63.3	62.0	61.1
1993	62.3	60.6	59.0
1994	62.1	60.0	57.6
1995	62.7	60.3	57.5
1996	63.5	60.7	57.7
1997	64.4	61.8	58.5
1998	65.0	62.3	58.6
1999	66.1	63.6	59.9
2000	67.2	64.7	60.9
2001	68.0	65.6	61.8
2002	68.5	66.0	61.8
2003	67.9	65.1	60.3
2004	68.4	65.7	61.1
2005	68.8	66.0	61.2
2006	69.7	67.0	61.7
2007	70.0	67.4	62.0
];

yrs=cdata(:,1);
SurvRate=cdata(:,2:4)/100;

figure(1); figsetup;
plot(yrs,SurvRate(:,1),'Color',mypurp,'LineWidth',LW); hold on;
plot(yrs,SurvRate(:,2),'Color',myblue,'LineWidth',LW);
plot(yrs,SurvRate(:,3),'Color',mygreen,'LineWidth',LW);
chadfig2('Year','5-Year Survival Rate',1,0);
makefigwide;
text(2007,.665,'Ages 50+');
text(1998,.57,'Ages 65+');
text(1995,.67,'All ages');
print('-depsc',[CaseName '_SurvRate']);
print('-dpsc',CaseName);



%  Mortality Rate Age-Adjusted
%  All Cancer Sites
%  All Ages  White  Both Sexes
% 1975-2012
% http://seer.cancer.gov/faststats/selections.php
% Downloaded 11/13/15

cmortdata=[
%	All Ages	Ages 50+	Ages 65+
%Year	Rate	Rate	Rate
1975	196.3316	632.3213	993.7764
1976	199.3802	644.602	1015.4072
1977	199.6736	647.1142	1019.2481
1978	201.1381	653.5394	1031.2633
1979	201.1979	655.6517	1038.6876
1980	203.2736	662.7401	1052.5471
1981	202.6429	662.6035	1053.7501
1982	204.5418	669.4965	1067.5592
1983	205.17	673.5869	1074.7424
1984	206.6587	679.2184	1083.6888
1985	207.2522	680.9303	1086.9757
1986	207.7301	683.874	1097.4368
1987	207.7809	686.3904	1100.6931
1988	208.4836	689.4763	1108.8623
1989	209.9575	695.9085	1126.2636
1990	210.4116	698.0637	1134.4135
1991	210.6208	699.1376	1139.5792
1992	209.2426	695.7798	1141.8862
1993	209.1573	697.0479	1147.8029
1994	207.8259	693.3313	1144.8805
1995	206.0856	687.9982	1142.0041
1996	203.4031	679.8175	1130.5334
1997	199.945	668.4678	1117.4867
1998	197.5595	660.9922	1111.5644
1999	197.7542	662.6227	1118.0447
2000	196.3704	658.3875	1114.5096
2001	193.9779	649.2642	1098.8562
2002	192.3762	644.4046	1094.2153
2003	189.1006	633.7614	1077.866
2004	185.2059	621.4771	1059.8622
2005	183.8733	616.6332	1054.4173
2006	181.1004	607.7563	1038.5316
2007	178.2993	598.6579	1027.2331
2008	175.6948	590.0623	1013.2638
2009	173.0255	580.144	994.2029
2010	171.3663	575.7246	988.7978
2011	168.4837	566.4279	971.2764
2012	166.4442	559.4529	957.2375
];

cmort=cmortdata(:,2:4);



% Publications and Clinical Trials for "Neoplasms"
% Uses python pubmedscrapernoprog.py "Neoplasms" --start 1961 --end 2015 --title allcancers
%  -- This is a "flow" number, not a stock...
% See pubmedscraper.readme for details and pubmed_results.xls for all results.

effortdata=[
1961	11132	NaN %0
1962	12017	NaN %0
1963	15898	1
1964	19085	3
1965	16976	55
1966	16376	62
1967	18456	84
1968	20047	128
1969	20359	109
1970	20646	134
1971	21719	112
1972	22248	164
1973	22774	201
1974	23634	235
1975	24740	319
1976	25259	362
1977	26840	491
1978	28436	526
1979	30293	531
1980	31352	470
1981	32112	599
1982	33746	663
1983	36098	659
1984	38892	838
1985	40379	899
1986	41368	982
1987	42254	973
1988	43492	1108
1989	46852	1353
1990	47773	1730
1991	46023	1843
1992	47522	2039
1993	48778	2139
1994	50926	3301
1995	51428	3292
1996	53257	3129
1997	54226	3191
1998	55776	3188
1999	57077	3512
2000	60055	3316
2001	62366	3047
2002	65661	3235
2003	70912	3719
2004	74610	4218
2005	81907	4620
2006	86634	4496
2007	92492	4581
2008	97794	4619
2009	102354	4939
2010	111384	5297
2011	120721	5832
2012	128020	6480
2013	134316	6594
2014	140802	6532
%2015	138330	6233
];

pubyrs=effortdata(:,1);
Publications=effortdata(:,2);
Trials=effortdata(:,3);
PubScaleString = '25 100 400 1600 6400 25600 102400';
TFPScaleString = '1 2 4 8 16 32';

FiveYearSurvRate=SurvRate(:,2); % Age 50+
MortalityRate_uncond=cmort(:,2); % Age 50+

% Adjust for Lambda
Publications=Publications.^Lambda;
Trials=Trials.^Lambda;

% IDEA TFP and Plots -- call the function
TextLocations=[1994 1985; 1992 2003]; % Text string locations for 3 key figures
mortality(CaseName,FiveYearSurvRate,MortalityRate_uncond,yrs,Publications,Trials,pubyrs,PubScaleString,TFPScaleString,TextLocations,StopForFigLabels);


diary off;
