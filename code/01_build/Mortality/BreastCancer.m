% BreastCancer.m  
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
CaseName='BreastCancer';
diarychad(CaseName,MasterCase);
run ../ShowMasterParameters
if strcmp(MasterCase,'Main')~=1; CaseName=[CaseName '_' MasterCase]; end;
definecolors;



% 5-Year Relative Survival By Year Dx
%  Breast Cancer S
%  All Ages  All Races  Women
% 1975-2012 
% http://seer.cancer.gov/faststats/selections.php
% Downloaded 11/13/15
cdata=[
%	All Ages	Ages 50+	Ages 65+
%Year ofDiagnosis	Rate	Rate	Rate
1975	75.2	74.9	76.3
1976	74.4	73.6	72.8
1977	74.8	74.2	73.6
1978	74.3	73.8	74.5
1979	74.1	73.9	73
1980	74.8	74.6	75.2
1981	75.5	75	76
1982	76.3	75.7	75.1
1983	76.3	76.3	75.8
1984	78.1	78.5	78.9
1985	78.4	78.6	78.8
1986	80.1	80.8	80.7
1987	83.3	84.4	84.9
1988	84.5	85.3	86.1
1989	84.3	85.2	85.8
1990	84.6	85.5	86.4
1991	85.2	85.8	86.3
1992	85.8	86.6	86.9
1993	85.7	86.1	85.9
1994	86.5	87.4	87.3
1995	86.8	87.8	88
1996	86.6	87.1	86.4
1997	88.3	88.9	88.8
1998	89.5	90.3	90.2
1999	89.6	90.1	90.1
2000	90.1	90.6	90.3
2001	89.4	90.1	90.2
2002	90.2	90.7	90.5
2003	89.7	89.8	89
2004	89.9	90.1	89.8
2005	90.4	90.4	90
2006	90.6	90.5	89.3
2007	91	90.7	89.8
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





% Age-Adjusted U.S. Mortality Rates: Breast Cancer
% By Cancer Site
% All Races  Female
% 1975-2012 
% http://seer.cancer.gov/faststats/selections.php
% Downloaded 10/25/15
% Mortality source: US Mortality Files, National Center for Health Statistics, CDC.
% Rates are per 100,000 and are age-adjusted to the 2000 US Std Population (19 age groups - Census P25-1130). April 2015, National Cancer Institute.

bcdata=[
%Year	All Ages   50+      65+
1975	31.4483	89.9359	114.3853
1976	31.804	92.2119	116.5642
1977	32.4813	94.3417	120.0644
1978	31.7345	92.0811	116.0801
1979	31.2139	90.4735	115.6253
1980	31.6848	92.2181	117.7566
1981	31.917	93.3348	120.9383
1982	32.189	94.4283	122.8261
1983	32.0742	94.6966	123.1597
1984	32.8972	96.5743	126.8901
1985	32.9754	96.9018	126.7415
1986	32.8699	96.3189	127.8369
1987	32.6571	96.077	127.2731
1988	33.2015	98.1802	130.6484
1989	33.2318	98.2159	133.3777
1990	33.1381	98.1355	133.7607
1991	32.6875	96.9102	132.2075
1992	31.644	94.1515	130.4051
1993	31.3907	94.1758	131.6337
1994	30.9172	92.5804	130.045
1995	30.5502	91.4609	127.7976
1996	29.4924	88.5257	124.753
1997	28.2149	84.5298	118.5523
1998	27.5403	83.0507	117.6772
1999	26.6068	81.2245	116.5681
2000	26.6417	80.9906	116.6057
2001	26.0123	78.7724	112.6434
2002	25.6234	77.971	112.617
2003	25.274	76.85	110.737
2004	24.4943	74.9887	107.7287
2005	24.1427	73.7397	106.6082
2006	23.5567	72.0061	104.3124
2007	22.9635	70.6026	103.5155
2008	22.5545	69.2048	101.965
2009	22.2428	67.8832	99.8585
2010	21.9231	67.472	99.4793
2011	21.5442	66.2501	97.8108
2012	21.278	64.9722	96.3482
];

byrs=bcdata(:,1);
mort=bcdata(:,2:4);



% Publications and Clinical Trials for "Breast Neoplasms"
% Uses python pubmedscrapernoprog.py "Breast Neoplasms" --start 1961 --end 2015 --title breastcancer
%  -- This is a "flow" number, not a stock...
% See pubmedscraper.readme for details and pubmed_results.xls for all results.

effortdata=[
%Year	Pubs      Clinical trials 
1961	426	NaN %0
1962	536	NaN %0
1963	688	NaN %0
1964	994	1
1965	623	6
1966	584	9
1967	847	9
1968	866	20
1969	1040	12
1970	955	21
1971	1129	14
1972	1069	20
1973	1152	28
1974	1293	33
1975	1539	36
1976	1458	46
1977	1804	95
1978	1747	86
1979	1770	79
1980	1982	105
1981	1941	105
1982	2035	107
1983	2113	111
1984	2465	151
1985	2521	168
1986	2487	187
1987	2554	144
1988	2782	150
1989	3264	199
1990	3304	217
1991	3265	213
1992	3737	245
1993	3894	266
1994	4422	382
1995	4522	376
1996	4923	400
1997	5241	406
1998	5644	398
1999	5727	495
2000	6394	445
2001	6361	421
2002	6863	406
2003	7281	484
2004	7723	558
2005	8598	637
2006	9093	588
2007	9575	604
2008	10328	662
2009	10757	665
2010	12081	734
2011	12938	786
2012	13711	862
2013	13855	897
2014	14367	873
%2015	14357	808
];

pubyrs=effortdata(:,1);
Publications=effortdata(:,2);
Trials=effortdata(:,3);
PubScaleString = '25 50 100 200 400 800 1600 3200 6400 12800';
TFPScaleString = '1/2 1 2 4 8 16 32 64 128';


FiveYearSurvRate=SurvRate(:,2); % Age 50+
MortalityRate_uncond=mort(:,2); % Age 50+

% Adjust for Lambda
Publications=Publications.^Lambda;
Trials=Trials.^Lambda;

% IDEA TFP and Plots -- call the function
TextLocations=[1994 1983; 1990 2003]; % Text string locations for 3 key figures
mortality(CaseName,FiveYearSurvRate,MortalityRate_uncond,yrs,Publications,Trials,pubyrs,PubScaleString,TFPScaleString,TextLocations,StopForFigLabels);


diary off;


