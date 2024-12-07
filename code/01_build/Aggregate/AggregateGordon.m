% AggregateGordon.m  6/17/2016
%
%  Basic Idea TFP calculation using Gordon's decadal TFP growth numbers
%  and the NIPA IPP numbers
%
%  NIPA data on R&D and Intellectual Property Products, via FRED (RND data list)
%  See RND2015-Nipa.xls
%
%  
%  GDPA	        -- Nominal GDP
%  Y001RC1A027NBEA -- Gross Private Domestic Investment: Intellectual Property Products
%  Y006RC1A027NBEA --   GPDI: Intellectual Property Products: R%D
%  Y055RC1A027NBEA -- Government Gross Investment: Intellectual Property Products
%  Y057RC1A027NBEA --   GGI: Intellectual Property Products: R%D
%  Y694RC1A027NBEA -- Gross Domestic Product: Research and Development
%
%  This last number is the sum of the private and govt R&D numbers.

clear;
diarychad('AggregateGordon');


tfpdata=[ 
% From Bob Gordon Figure 16-5. Currently a rough guess
%  See GordonCh16tables_151226.xls, "New TFP", cells T154 and following.
% 	New
%Decade	Annual TFP Growth
%1900	0.3747
%1910	0.2516
%1920	0.7521
%1930	1.2460 % The 1930 observation is for the 1920s
1940	1.8155
1950	3.3888
1960	1.6026
1970	1.4009
1980	0.3445
1990	0.7828
2000	0.7652
2014	0.6800
         ];


tfpgrowth=tfpdata(:,2);
years=tfpdata(:,1);
DecadeNames=strmat('1930s 1940s 1950s 1960s 1970s 1980s 1990s 2000s');

% % From RNDSalaries.m
% censusdata=[
% %Year	AvgOccIncome	Education	Wage
% %1950		1102.8	3.888	0.519
% 1930            5400*.380    NaN     NaN   % Chad guess based on nominal gdp per capita
% 1940            5400*.395    NaN     NaN   % Chad guess based on nominal gdp per capita
% 1950            5400    NaN     NaN   % Chad guess based on CPI and 2% real
% 1960		8130.4	16.24	3.803
% 1970		12729.7	16.12	5.951
% 1980		25825.8	17.28	11.687
% 1990		40195.8	17.03	17.630
% 2000		58399.7	17.49	24.935
% %2010		82108.7	17.7	32.82
% 2014            82108.7*1.025^4  NaN NaN    
%  ];

% disp 'NOTE WELL: The WAGE OF SCIENTISTS data are based on nominal GDP per person for 1940 and 1930.';
% disp '  We should do better on this...';

% w1=censusdata(:,2);
% w2=w1;
% w1=trimr(w1,1,0);
% w2=trimr(w2,0,1);
% WageSci=w1.^(1/2).*w2.^(1/2); % Geometric average to get decadal wage








% Title:               Gross Domestic Product: Research and Development
% Series ID:           Y694RC1A027NBEA
% Source:              US. Bureau of Economic Analysis
% Release:             Gross Domestic Product
% Seasonal Adjustment: Not Seasonally Adjusted
% Frequency:           Annual
% Units:               Billions of Dollars
% Date Range:          1929-01-01 to 2015-01-01
% Last Updated:        2016-03-25 1:31 PM CDT
% Notes:               BEA Account Code: Y694RC1
% https://research.stlouisfed.org/fred2/series/Y694RC1A027NBEA

datarnd=[
1929    0.3
1930    0.3
1931    0.3
1932    0.3
1933    0.3
1934    0.3
1935    0.3
1936    0.4
1937    0.4
1938    0.4
1939    0.4
1940    0.5
1941    0.9
1942    1.1
1943    1.4
1944    2.1
1945    2.1
1946    2.2
1947    2.4
1948    2.7
1949    2.7
1950    3.1
1951    3.5
1952    4.3
1953    5.1
1954    5.6
1955    6.3
1956    8.4
1957    9.6
1958   10.4
1959   11.4
1960   12.7
1961   13.9
1962   15.4
1963   17.6
1964   19.3
1965   20.8
1966   23.2
1967   24.9
1968   26.6
1969   28.2
1970   28.3
1971   29.1
1972   31.3
1973   33.8
1974   36.4
1975     39
1976   43.1
1977   47.5
1978   53.5
1979   60.9
1980   69.8
1981   79.9
1982     89
1983   98.4
1984  111.4
1985  125.1
1986  132.0
1987  140.2
1988  148.2
1989  155.9
1990  164.2
1991  170.0
1992  171.9
1993  172.0
1994  175.0
1995  187.5
1996  199.8
1997  212.0
1998  222.4
1999  237.2
2000  255.6
2001  263.2
2002  265.7
2003  277.6
2004  291.2
2005  313.1
2006  334.6
2007  360.0
2008  380.5
2009  374.8
2010  392.1
2011  404.1
2012  413.5
2013  427.9
2014  444.8
%2015  468.3
];

annualrnd=datarnd(:,2);
annualyrs=datarnd(:,1);
yr0=1928;


load WageScientistData
WageSci=WageScientist(annualyrs-WageYears(1)+1);
WageNotes


yrs=[1930 1940
     1940 1950
     1950 1960
     1960 1970
     1970 1980
     1980 1990
     1990 2000
     2000 2014
     ];

T=size(yrs,1);
IdeaTFP=zeros(T,1);


%RND=exp(average(log(annualrnd),yrs-yr0)); % Geometric average
%Scientists=RND./WageSci;
RND=annualrnd;
ScientistsAnnual=RND./WageSci*10^9;
Scientists=exp(average(log(ScientistsAnnual),yrs-yr0)); % Geometric Average
Scientists=Scientists/Scientists(1);
IdeaTFP=tfpgrowth./Scientists;
IdeaTFP=IdeaTFP/IdeaTFP(1);

disp ' '; 
disp 'Underlying annual data';
cshow(' ',[annualyrs RND WageSci ScientistsAnnual],'%8.0f %15.0f','Year RND($b) WageSci Scientists');

disp ' ';
disp 'RESULTS';
cshow(DecadeNames,[tfpgrowth Scientists IdeaTFP*100],'%12.2f %12.2f','TFPGrowth Scientists IdeaTFP');

disp ' ';
TT=.5*(2000+2014) - .5*(1940+1930)
gSci =100*log(Scientists(end)/Scientists(1))/TT;
giTFP=100*log(IdeaTFP(end)/IdeaTFP(1))/TT;
fprintf('The implied average growth rate of scientists is %8.2f percent\n',gSci);
fprintf('The implied average growth rate of idea TFP   is %8.2f percent\n',giTFP);

disp ' ';
fprintf('Idea TFP Factor decline, 1930s - 2000s = %8.3f\n',IdeaTFP(1)/IdeaTFP(end));
fprintf('Idea TFP Factor decline, 1960s - 2000s = %8.3f\n',IdeaTFP(4)/IdeaTFP(end));
fprintf('Idea TFP Factor decline, 1980s - 2000s = %8.3f\n',IdeaTFP(6)/IdeaTFP(end));
disp ' ';
fprintf('Scientists factor increase, 1930s - 2000s = %8.3f\n',Scientists(end)/Scientists(1));
fprintf('Scientists factor increase, 1960s - 2000s = %8.3f\n',Scientists(end)/Scientists(4));
fprintf('Scientists factor increase, 1980s - 2000s = %8.3f\n',Scientists(end)/Scientists(6));



Decades=yrs(:,1); 

figure(1); figsetup;
definecolors
[ax,h1,h2]=plotyy(Decades,log2(IdeaTFP),Decades,log2(Scientists));
darkfactor=.8;
set(h1,'LineWidth',LW,'Color',myblue);
set(h2,'LineWidth',LW,'Color',mygreen);
set(ax(1),'ycolor',myblue*darkfactor);
set(ax(2),'ycolor',mygreen*darkfactor);
relabelaxis(Decades,DecadeNames,'x',ax(1));
relabelaxis(Decades,DecadeNames,'x',ax(2));
fs=14;
str=mlstring('Idea TFP\\ (left scale)');
text(1935,log(1/4.8),str,'FontSize',fs);
str=mlstring('Effective number of\\ researchers (right scale)');
text(1973,log(1/1.6),str,'FontSize',fs);
set(ax(1),'Box','off');
set(ax(2),'Box','off');
makefigwide;

axnum=(-8:0)';
axlab=strmat('1/256#1/128# 1/64 # 1/32 # 1/16 #  1/8 #  1/4 #  1/2 #   1','#');
imin=floor(min(log2(IdeaTFP)));  % e.g. -4 ==> 1/16
indx=find(axnum==imin);
relabelaxis(axnum(indx:end),axlab(indx:end,:),'y',ax(1));
set(ax(1),'YLim',[axnum(indx) axnum(end)]);

axnum=(0:5)';
axlab=strmat(' 1 # 2 # 4 # 8 # 16# 32','#');
smax=ceil(max(log2(Scientists)));  % e.g. 4 ==> 16
indx=find(axnum==smax);
relabelaxis(axnum(1:indx),axlab(1:indx,:),'y',ax(2));
chadfig2(' ','Index (1930=1)',1,0);
chadfigyy(ax(2),'Index (1930=1)');
print('-dpng','AggregateGordon');
print('-dpdf','AggregateGordon');


