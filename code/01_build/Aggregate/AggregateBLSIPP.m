% AggregateBLSIPP.m  6/17/2016
%
%   USES Total IPP instead of just R\&D
%
%  Basic Idea TFP calculation using BLS's decadal TFP growth numbers
%  and the NIPA IPP numbers
%
%  NIPA data on R&D and Intellectual Property Products, via FRED (RND data list)


clear;
global MasterCase Lambda;
diarychad('AggregateBLSIPP',MasterCase);
run ../ShowMasterParameters
figname='AggregateBLSIPP';
if strcmp(MasterCase,'Main')~=1; figname=[figname '_' MasterCase]; end;

Gordondata=[ 
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

disp 'Gordon Data';
cshow(' ',Gordondata,'%6.0f %8.2f');


GordonGrowth=Gordondata(:,2);
GordonYears=Gordondata(:,1);
DecadeNames=strmat('1930s 1940s 1950s 1960s 1970s 1980s 1990s 2000s');


% Y001RC1A027NBEA
% FRED Graph Observations		FRED Graph Observations			
% Federal Reserve Economic Data		Federal Reserve Economic Data			
% Link: https://fred.stlouisfed.org		Link: https://fred.stlouisfed.org			
% Help: https://fred.stlouisfed.org/help-faq		Help: https://fred.stlouisfed.org/help-faq			
% Economic Research Division		Economic Research Division			
% Federal Reserve Bank of St. Louis		Federal Reserve Bank of St. Louis			
% Gross Private Domestic Investment: Fixed Investment: Nonresidential: Intellectual Property Products, Billions of Dollars, Annual, Not Seasonally Adjusted					
% Y001RC1A027NBEA		Y055RC1A027NBEA	Government Gross Investment: Intellectual Property Products, Billions of Dollars, Annual, Not Seasonally Adjusted		
					
% Frequency: Annual		Frequency: Annual			
% observation_date	Y001RC1A027NBEA	observation_date	Y055RC1A027NBEA		TOTAL GPDI in IPP

datarnd=[  %  PvtIPP                 GovtIPP        TotalIPP
1929-01-01	0.6	1929-01-01	0.1		0.7
1930-01-01	0.6	1930-01-01	0.1		0.7
1931-01-01	0.5	1931-01-01	0.1		0.6
1932-01-01	0.4	1932-01-01	0.1		0.5
1933-01-01	0.4	1933-01-01	0.1		0.5
1934-01-01	0.5	1934-01-01	0.1		0.6
1935-01-01	0.6	1935-01-01	0.1		0.7
1936-01-01	0.6	1936-01-01	0.1		0.7
1937-01-01	0.7	1937-01-01	0.1		0.8
1938-01-01	0.8	1938-01-01	0.1		0.9
1939-01-01	0.8	1939-01-01	0.1		0.9
1940-01-01	0.8	1940-01-01	0.1		0.9
1941-01-01	1.1	1941-01-01	0.3		1.4
1942-01-01	1.2	1942-01-01	0.5		1.7
1943-01-01	1.1	1943-01-01	0.9		2.0
1944-01-01	1.2	1944-01-01	1.6		2.8
1945-01-01	1.4	1945-01-01	1.5		2.9
1946-01-01	1.8	1946-01-01	1.4		3.2
1947-01-01	2.0	1947-01-01	1.4		3.4
1948-01-01	2.1	1948-01-01	1.6		3.7
1949-01-01	2.0	1949-01-01	1.7		3.7
1950-01-01	2.3	1950-01-01	1.9		4.2
1951-01-01	2.4	1951-01-01	2.1		4.5
1952-01-01	3.0	1952-01-01	2.4		5.4
1953-01-01	3.7	1953-01-01	2.7		6.4
1954-01-01	3.9	1954-01-01	3.0		6.9
1955-01-01	4.3	1955-01-01	3.6		7.9
1956-01-01	5.2	1956-01-01	4.8		10.0
1957-01-01	5.6	1957-01-01	5.9		11.5
1958-01-01	6.0	1958-01-01	6.4		12.4
1959-01-01	6.6	1959-01-01	7.0		13.6
1960-01-01	7.1	1960-01-01	7.8		14.9
1961-01-01	8.0	1961-01-01	8.8		16.8
1962-01-01	8.4	1962-01-01	9.9		18.3
1963-01-01	9.2	1963-01-01	11.7		20.9
1964-01-01	9.8	1964-01-01	12.9		22.7
1965-01-01	11.1	1965-01-01	13.8		24.9
1966-01-01	12.8	1966-01-01	15.4		28.2
1967-01-01	14.0	1967-01-01	16.2		30.2
1968-01-01	15.6	1968-01-01	17.0		32.6
1969-01-01	17.2	1969-01-01	17.7		34.9
1970-01-01	17.9	1970-01-01	17.6		35.5
1971-01-01	18.7	1971-01-01	18.1		36.8
1972-01-01	20.6	1972-01-01	19.3		39.9
1973-01-01	22.7	1973-01-01	20.3		43.0
1974-01-01	25.5	1974-01-01	21.5		47.0
1975-01-01	27.8	1975-01-01	23.3		51.1
1976-01-01	32.2	1976-01-01	25.5		57.7
1977-01-01	35.8	1977-01-01	27.9		63.7
1978-01-01	40.4	1978-01-01	31.0		71.4
1979-01-01	48.1	1979-01-01	35.0		83.1
1980-01-01	54.4	1980-01-01	39.6		94.0
1981-01-01	64.8	1981-01-01	45.0		109.8
1982-01-01	72.7	1982-01-01	49.7		122.4
1983-01-01	81.3	1983-01-01	55.2		136.5
1984-01-01	95.1	1984-01-01	62.2		157.3
1985-01-01	105.3	1985-01-01	71.0		176.3
1986-01-01	113.5	1986-01-01	75.2		188.7
1987-01-01	120.1	1987-01-01	81.7		201.8
1988-01-01	132.7	1988-01-01	85.1		217.8
1989-01-01	150.1	1989-01-01	87.8		237.9
1990-01-01	164.4	1990-01-01	91.1		255.5
1991-01-01	179.1	1991-01-01	91.4		270.5
1992-01-01	187.7	1992-01-01	91.6		279.3
1993-01-01	196.9	1993-01-01	91.4		288.3
1994-01-01	205.7	1994-01-01	92.0		297.7
1995-01-01	226.8	1995-01-01	94.0		320.8
1996-01-01	253.3	1996-01-01	95.5		348.8
1997-01-01	288.0	1997-01-01	98.3		386.3
1998-01-01	317.7	1998-01-01	102.3		420.0
1999-01-01	364.0	1999-01-01	106.5		470.5
2000-01-01	409.5	2000-01-01	113.2		522.7
2001-01-01	412.6	2001-01-01	119.7		532.3
2002-01-01	406.4	2002-01-01	126.0		532.4
2003-01-01	420.9	2003-01-01	136.5		557.4
2004-01-01	442.1	2004-01-01	145.5		587.6
2005-01-01	475.1	2005-01-01	153.9		629.0
2006-01-01	504.6	2006-01-01	160.6		665.2
2007-01-01	537.9	2007-01-01	169.0		706.9
2008-01-01	563.4	2008-01-01	177.2		740.6
2009-01-01	550.9	2009-01-01	179.8		730.7
2010-01-01	564.3	2010-01-01	187.4		751.7
2011-01-01	592.2	2011-01-01	191.6		783.8
2012-01-01	621.7	2012-01-01	189.2		810.9
2013-01-01	649.9	2013-01-01	188.1		838.0
2014-01-01	690.0	2014-01-01	187.2		877.2
2015-01-01	728.6	2015-01-01	190.8		919.4
];


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

databasic=[
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
2015  468.3
];


annualrnd=datarnd(:,5);
annualyrs=datarnd(:,1)+2;
annualbasic=databasic(:,2);
yr0=1928;


% BLS TFP Indexes
% From mfp_tables_historical-2017-02-17.xls
% Downloaded from BLS on 2/17/17
%   https://www.bls.gov/mfp/tables.htm
% Note: We will add back in the contributions of R&D and IPP

%Year	Multifactor Productivity	Contribution of Research and Development  Intensity	Contribution of All Other  Intellectual Property Products Intensity
% Year   TFP    RND     IPP
blsdata=[			
1948	44.186	NaN	NaN
1949	44.323	NaN	NaN
1950	47.495	NaN	NaN
1951	48.629	NaN	NaN
1952	49.466	NaN	NaN
1953	50.755	NaN	NaN
1954	50.728	NaN	NaN
1955	52.889	NaN	NaN
1956	52.523	NaN	NaN
1957	53.310	NaN	NaN
1958	53.528	NaN	NaN
1959	55.923	NaN	NaN
1960	56.267	NaN	NaN
1961	57.470	NaN	NaN
1962	59.560	NaN	NaN
1963	61.302	NaN	NaN
1964	63.698	NaN	NaN
1965	65.763	NaN	NaN
1966	67.773	NaN	NaN
1967	67.853	NaN	NaN
1968	69.562	NaN	NaN
1969	69.288	NaN	NaN
1970	69.134	NaN	NaN
1971	71.302	NaN	NaN
1972	73.337	NaN	NaN
1973	75.357	NaN	NaN
1974	72.747	NaN	NaN
1975	73.430	NaN	NaN
1976	76.096	NaN	NaN
1977	77.356	NaN	NaN
1978	78.401	NaN	NaN
1979	78.094	NaN	NaN
1980	76.292	NaN	NaN
1981	76.455	NaN	NaN
1982	73.887	NaN	NaN
1983	76.026	NaN	NaN
1984	78.305	NaN	NaN
1985	79.309	NaN	NaN
1986	80.563	NaN	NaN
1987	80.844	98.040	95.473
1988	81.622	98.109	95.587
1989	81.978	98.175	95.763
1990	82.686	98.326	96.153
1991	82.304	98.519	96.599
1992	85.038	98.644	96.988
1993	84.721	98.674	97.295
1994	85.246	98.654	97.567
1995	84.797	98.671	97.909
1996	86.421	98.740	98.347
1997	87.418	98.778	98.818
1998	88.517	98.853	99.291
1999	90.378	98.922	99.617
2000	91.957	99.015	99.820
2001	92.435	99.165	99.967
2002	94.397	99.303	99.942
2003	96.638	99.386	99.675
2004	99.089	99.407	99.300
2005	100.593	99.420	99.064
2006	100.917	99.436	98.969
2007	101.381	99.516	99.052
2008	100.174	99.678	99.454
2009	100.000	100.000	100.000
2010	102.869	100.094	99.952
2011	102.986	100.110	99.846
2012	103.594	100.116	99.798
2013	103.841	100.152	99.839
2014	104.558	100.176	99.927
2015	104.798	NaN	NaN
];

blsyrs=blsdata(:,1);
blslevel=blsdata(:,2);
bls_rnd=blsdata(:,3);
bls_ipp=blsdata(:,4);

% Add back the RND and IPP contributions, which we do not want taken out
% (only starts taking out in 1987)
rawgrowth=delchange(log(blslevel));
rnd_contribution=delchange(log(bls_rnd));
ipp_contribution=delchange(log(bls_ipp));
rnd_contribution(isnan(rnd_contribution))=0; % Replace NaNs
ipp_contribution(isnan(ipp_contribution))=0; % Replace NaNs
tfpgrowth_rndipp=rawgrowth+rnd_contribution+ipp_contribution;
tfpindex=exp(cumsum([0; tfpgrowth_rndipp]));
tfpindex=tfpindex/tfpindex(1)*blslevel(1);

disp ' ';
disp 'BLS Data for adding back RND and IPP';
blah=trimr([blslevel tfpindex],0,1);
fmt='%8.0f %8.4f %8.4f %8.4f %8.4f %12.2f %12.2f';
cshow(' ',[trimr(blsyrs,0,1) rawgrowth rnd_contribution ipp_contribution tfpgrowth_rndipp blah],fmt,'Year BLS RND IPP Fixed BLSIndex TFPIndex');
disp ' ';

blsAvgYears=[1950 
             1960 
             1970 
             1980 
             1990 
             2000 
             2014];
blsgrowth=delchange(log(blslevel(blsAvgYears-1947))) ./ delchange(blsAvgYears)*100;
tfpgrowth_fixed=delchange(log(tfpindex(blsAvgYears-1947))) ./ delchange(blsAvgYears)*100;
disp ' ';
disp 'Average Annual TFP Growth: Private Business Sector (BLS, by ending year)';
cshow(' ',[trimr(blsAvgYears,1,0) blsgrowth tfpgrowth_fixed],'%6.0f %8.2f','Year BLSRaw BLS+RND');


disp ' '; 
disp 'Merging Gordon data for 1930s and 1940s with BLS data for 1950s and beyond';
years=[GordonYears(1:2); trimr(blsAvgYears,1,0)];
tfpgrowth=[GordonGrowth(1:2); tfpgrowth_fixed];
disp 'Merged data:';
cshow(' ',[years tfpgrowth],'%6.0f %8.2f');


load ../WageSci/WageScientistData
WageSci=WageScientist(annualyrs-WageYears(1)+1);
WageNotes

yrs=[1930 1940
     1940 1950
     1950 1960
     1960 1970
     1970 1980
     1980 1990
     1990 2000
     2000 2015
     ];

T=size(yrs,1);
IdeaTFP=zeros(T,1);


%RND=exp(average(log(annualrnd),yrs-yr0)); % Geometric average
%Scientists=RND./WageSci;
RND=annualrnd;
ScientistsAnnual=RND./WageSci*10^9;
RNDBasic=annualbasic;
ScientistsBasic=RNDBasic./WageSci*10^9;

Scientists=exp(average(log(ScientistsAnnual),yrs-yr0)); % Geometric Average
Scientists=Scientists/Scientists(1);
Scientists=Scientists.^Lambda; % Adjusting effective research by lambda
IdeaTFP=tfpgrowth./Scientists;
IdeaTFP=IdeaTFP/IdeaTFP(1);

disp ' '; 
disp 'Underlying annual data';
cshow(' ',[annualyrs RND WageSci ScientistsAnnual ScientistsBasic],'%8.0f %15.0f','Year IPP($b) WageSci ScientistsIpp SciBasic');

% Plot scientists
definecolors
ScientistsNormalized=ScientistsAnnual/ScientistsAnnual(1);
BasicNormalized=ScientistsBasic/ScientistsBasic(1);
figure(2); figsetup;
%labs='200 400 800 1600 3200 6400 12800';
%plotlog(annualyrs,ScientistsAnnual/1000,'-',labs);
vals=[1 2 4 8 16 32 64]';
greygrid([1920 2020],log([1 4 16 64]));
plot(annualyrs,log(BasicNormalized),'-','Color',mygreen,'LineWidth',LW);
plot(annualyrs,log(ScientistsNormalized),'-','Color',myblue,'LineWidth',LW);
relabelaxis(log(vals),num2str(vals));
chadfig2('Year','Index, 1929=1',1,0);
makefigwide
text(1978,log(8),mlstring('        Broad definition (all\\ intellectual property products)'));
text(1951,log(32),mlstring('   Narrow definition\\ (R&D spending only)'));
print('-depsc',[figname '-Scientists']);

disp ' ';
disp 'RESULTS';
cshow(DecadeNames,[tfpgrowth Scientists IdeaTFP*100],'%12.2f %12.2f','TFPGrowth Scientists IdeaTFP');
disp ' ';
fprintf('Mean tfpgrowth =  %12.2f\n',mean(tfpgrowth));


disp ' ';
TT=.5*(2000+2015) - .5*(1940+1930)
gSci =100*log(Scientists(end)/Scientists(1))/TT;
giTFP=100*log(IdeaTFP(end)/IdeaTFP(1))/TT;
fprintf('The implied average growth rate of scientists is %8.2f percent\n',gSci);
%fprintf('                            scientists^lambda is %8.2f percent\n',gSci*Lambda);
fprintf('The implied average growth rate of idea TFP   is %8.2f percent\n',giTFP);
fprintf('      Half life of idea TFP = %8.2f years\n',-log(2)/giTFP*100);
fprintf('      Implied beta = %8.2f\n',-giTFP/mean(tfpgrowth));

disp ' ';
fprintf('Idea TFP Factor decline, 1930s - 2000s = %8.3f\n',IdeaTFP(1)/IdeaTFP(end));
fprintf('Idea TFP Factor decline, 1960s - 2000s = %8.3f\n',IdeaTFP(4)/IdeaTFP(end));
fprintf('Idea TFP Factor decline, 1980s - 2000s = %8.3f\n',IdeaTFP(6)/IdeaTFP(end));
disp ' ';
fprintf('Scientists factor increase, 1930s - 2000s = %8.3f\n',Scientists(end)/Scientists(1));
fprintf('Scientists factor increase, 1960s - 2000s = %8.3f\n',Scientists(end)/Scientists(4));
fprintf('Scientists factor increase, 1980s - 2000s = %8.3f\n',Scientists(end)/Scientists(6));

Decades=yrs(:,1); 
% here
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
str=mlstring('Research productivity\\       (left scale)');
text(1979,log2(1/12),str,'FontSize',fs);
str=mlstring('Effective number of\\ researchers (right scale)');
text(1973,log(1/1.6),str,'FontSize',fs);
set(ax(1),'Box','off');
set(ax(2),'Box','off');
makefigwide;
% here

df = table(Decades, log2(IdeaTFP), log2(Scientists));
df.Properties.VariableNames = {'Decades', 'log2(IdeaTFP)', 'log2(Scientists));'};
writetable(df, 'df.xlsx');

%axnum=(-8:1)';
%axlab=strmat('1/256#1/128# 1/64 # 1/32 # 1/16 #  1/8 #  1/4 #  1/2 #   1 #   2','#');
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
print('-depsc',figname);




figure(2); figsetup;
definecolors
[ax,h1,h2]=plotyy(Decades,tfpgrowth,Decades,(Scientists));
darkfactor=.8;
set(h1,'LineWidth',LW,'Color',myblue);
set(h2,'LineWidth',LW,'Color',mygreen);
set(ax(1),'ycolor',myblue*darkfactor);
set(ax(2),'ycolor',mygreen*darkfactor);
relabelaxis(Decades,DecadeNames,'x',ax(1));
relabelaxis(Decades,DecadeNames,'x',ax(2));
fs=14;
str=mlstring('U.S. TFP Growth\\ (left scale)');
text(1935,6,str,'FontSize',fs);
str=mlstring('Effective number of\\ researchers (right scale)');
text(1973,20,str,'FontSize',fs);
set(ax(1),'Box','off');
set(ax(2),'Box','off');
makefigwide;

set(ax(1),'YLim',[0 5]);
%relabelaxis(0:5,strmat('0% 1% 2% 3% 4% 5%'),'y',ax(1));
%relabelaxis(0:2:10,strmat('0% 2% 4% 6% 8% 10%'),'y',ax(1));
relabelaxis(0:5:25,strmat('0% 5% 10% 15% 20% 25%'),'y',ax(1));

axnum=(0:5)';
axlab=strmat(' 1 # 2 # 4 # 8 # 16# 32','#');
smax=ceil(max(log2(Scientists)));  % e.g. 4 ==> 16
                                   
%indx=find(axnum==smax);
%relabelaxis(axnum(1:indx),axlab(1:indx,:),'y',ax(2));
relabelaxis([0 5 10 15 20 25],strmat('0 5 10 15 20 25'),'y',ax(2));
chadfig2(' ','Growth rate',1,0);
chadfigyy(ax(2),'Factor Increase since 1930');
print('-depsc',[figname '2']);


diary off;