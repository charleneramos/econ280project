% SemiconductorTFP
%
%   NBER/CES Manufacturing TFP for 334413 (Semiconductor and Related Device Manufacturing)
%    from http://www.nber.org/data/nberces.html
%    Becker, Gray, Marvakov update of original Bartelsman and Gray data
%    1958-2011
%
%   July 2017 -- See MooresLawRND-2017-07-31.xls
%   for data details.
%
% Nominal data, in millions of dollars
%
%  Use Semiconductor TFP growth (smoothed) as output measure
%  and 5-year lag of R&D spending as input measure (w/ and w/o equipment RND)

clear; clc;
global MasterCase Lambda;
diarychad('SemiconductorTFP',MasterCase);
run ../ShowMasterParameters
figname='SemiconductorTFP';
if strcmp(MasterCase,'Main')~=1; figname=[figname '_' MasterCase]; end;

definecolors;

disp 'Use this many years to lag RND:'
YrsToLag = 5
HPSmoother=400


% TFP Growth Data dTFP5 (5-factor tfp growth)
% 334413 (Semiconductor and Related Device Manufacturing)

tfpdata =[
%1958     NaN
% 1959     0.3470000029    
% 1960     -0.1110000014   
% 1961     -0.2399999946   
% 1962     0.0359999985    
% 1963     0.0060000001    
% 1964     0.1220000014    
% 1965     0.1710000038    
% 1966     0.0450000018    
% 1967     0.0049999999    
% 1968     0.1089999974    
% 1969     0.0149999997    
% 1970     0.0299999993    
% 1971     0.1480000019    
% 1972     0.2259999961    
% 1973     0.0540000014    
% 1974     -0.0240000002   
1975     -0.0040000002   
1976     0.1659999937    
1977     0.1480000019    
1978     0.1870000064    
1979     0.1509999931    
1980     0.0359999985    
1981     0.0719999969    
1982     0.0480000004    
1983     0.0340000018    
1984     0.0599999987    
1985     -0.1019999981   
1986     0.0170000009    
1987     0.1059999987    
1988     0.075000003     
1989     0.1019999981    
1990     0.0970000029    
1991     0.1509999931    
1992     0.1780000031    
1993     0.224999994     
1994     0.3370000124    
1995     0.5879999995    
1996     0.3440000117    
1997     0.2129999995    
1998     -0.074000001    
1999     0.4420000017    
2000     0.4550000131    
2001     0.1529999971    
2002     0.0270000007    
2003     0.1630000025    
2004     0.1940000057    
2005     0.1010000035    
2006     -0.0089999996   
2007     0.1190000027    
2008     0.0729999989    
2009     -0.0250000004   
2010     0.3070000112    
2011     0.2380000055    
    ];

tfpyrs=tfpdata(:,1);
tfpgrowth_raw=tfpdata(:,2);
tfpgrowth_smooth=hpfilter(tfpgrowth_raw,HPSmoother);

disp 'TFP Growth Rates';
cshow(' ',[tfpyrs tfpgrowth_raw tfpgrowth_smooth],'%6.0f %8.4f','Year Raw Smoothed');

figure(1); figsetup;
plot(tfpyrs,tfpgrowth_raw);
plot(tfpyrs,tfpgrowth_smooth,'-','Color',myred);
chadfig('Year','Growth rate',1,0);
print('-dpsc',figname);

% Nominal data, in millions of dollars
version={'Narrow (no equip)','Narrow (w/ equip)','Broad (no equip)','Broad (w/ equip)'};
BaselineMoore=3  % Baseline case for plotting
version(3)

data=[    
%		For Semiconductor TFP		
%	Narrow		Broad	
%	Totals		Totals	
%	(exclude	(include	(exclude	(include
%  Year	equipment)	equipment)	equipment)	equipment)
1970	318.51	319.34	372.24	373.06
1971	355.02	355.99	407.25	408.22
1972	440.17	442.02	504.20	506.05
1973	532.98	535.55	624.37	626.95
1974	638.87	642.43	749.57	753.13
1975	679.24	681.19	786.74	788.69
1976	766.67	768.97	895.67	897.98
1977	941.71	944.90	1102.12	1105.31
1978	1103.26	1117.18	1314.99	1328.91
1979	1173.88	1195.14	1448.68	1469.94
1980	1379.50	1410.68	1733.85	1765.03
1981	1560.68	1603.01	1962.80	2005.13
1982	1989.53	2043.46	2442.50	2496.43
1983	2356.72	2423.70	2930.68	2997.66
1984	3020.20	3126.63	3806.23	3912.65
1985	3237.97	3361.98	4059.43	4183.44
1986	3816.56	3941.53	4659.67	4784.63
1987	4386.90	4529.71	5379.13	5521.93
1988	4686.14	4866.31	5784.40	5964.57
1989	4838.61	5082.39	5983.86	6227.64
1990	5380.18	5667.24	6662.07	6949.13
1991	5838.10	6121.82	7290.41	7574.13
1992	6044.51	6387.70	7683.07	8026.26
1993	6281.62	6669.70	8255.96	8644.04
1994	6763.27	7306.01	9060.04	9602.78
1995	7003.81	7922.72	9912.07	10830.98
1996	6478.34	7752.22	10302.82	11576.71
1997	6536.86	8267.69	11179.03	12909.85
1998	6709.09	8615.32	11838.70	13744.92
1999	7192.49	9367.62	13192.97	15368.10
2000	7316.96	10449.63	16101.86	19234.53
2001	6964.10	10820.50	15475.49	19331.89
2002	7241.73	10767.79	16010.17	19536.23
2003	7438.10	10841.56	16939.99	20343.44
2004	7616.56	11292.98	18451.32	22127.74
2005	7692.73	11315.25	19335.78	22958.29
2006	8730.82	13215.84	24205.78	28690.79
2007	8094.89	13148.85	22887.01	27940.97
2008	7869.82	13190.82	25017.21	30338.22
2009	7144.82	11825.88	23231.25	27912.31
2010	7704.19	13070.94	25536.00	30902.75
2011	8179.61	14068.73	28909.80	34798.92
2012	8147.40	14394.48	31773.32	38020.40
2013	8600.82	15539.00	34214.57	41152.74
2014	9097.71	16544.63	37148.94	44595.87
2015	8098.66	15750.74	36284.97	43937.05
];    
    
years=data(:,1);
rnd=data(:,2:5);

% Timing:
%   RND 1970-2015
%   TFP 1975=1974-5 to 2011=2010-11
%       == 1970 rnd   to    2006 rnd
rndyrs=tfpyrs-YrsToLag;
fprintf('Start Year:  TFPGrowth=%4.0f-%4.0f    RND=%4.0f\n',[tfpyrs(1)-1 tfpyrs(1) rndyrs(1)]);
fprintf('Final Year:  TFPGrowth=%4.0f-%4.0f    RND=%4.0f\n',[tfpyrs(end)-1 tfpyrs(end) rndyrs(end)]);
disp ' ';
rnd=rnd(rndyrs-1969,:);


%load RNDSalaries   % YearsWR WageResearch
%sci=rnd./WageResearch(years-1949);
load ../WageSci/WageScientistData
WageSci=WageScientist(rndyrs-WageYears(1)+1);
WageNotes

sci=div(rnd,WageSci);
sci=div(sci,sci(1,:)); % Index
sci=sci.^Lambda; % Adjusting effective research by lambda


itfp=tfpgrowth_smooth./sci;
itfp=itfp/itfp(1);
gmoore=mean(tfpgrowth_smooth);
fprintf('Mean smoothed TFP growth for semiconductors = %8.4f\n',gmoore);

tle='Year NarrowNOEQ NarrowEQUIP BroadNOEQ BroadEQUIP';
disp ' '; disp ' ';
disp 'Effective RND:'
cshow(' ',[tfpyrs sci],'%6.0f %12.2f',tle);
disp ' '; disp ' ';
disp 'IDEA TFP:'
cshow(' ',[tfpyrs itfp],'%6.0f %12.2f',tle);

disp ' ';
gSci =100*log(sci(end,:)./sci(1,:))/(tfpyrs(end)-tfpyrs(1));
giTFP=100*log(itfp(end,:)./itfp(1,:))/(tfpyrs(end)-tfpyrs(1));
halflife=-log(2)./giTFP*100;
beta=-giTFP/gmoore/100;

tle='Factor gSci giTFP HalfLife Beta';
fmt='%10.0f %10.1f %10.1f %10.1f %10.2f';
cshow(version,[sci(end,:)' gSci' giTFP' halflife' beta'],fmt,tle,'latex');


% for i=1:length(tle);
%     disp ' ';
%     disp(version{i});
%     fprintf('The implied average growth rate of scientists is %8.2f percent\n',gSci(i));
%     fprintf('The implied average growth rate of idea TFP   is %8.2f percent\n',giTFP(i));
%     fprintf('      Half life of idea TFP = %8.2f years\n',-log(2)/giTFP(i)*100);
%     fprintf('      Implied beta = %8.2f\n',-giTFP(i)/gmoore/100);
% end;

figure(1); figsetup;  makefigwide;
plot(tfpyrs,log(itfp),'-','LineWidth',4);
chadfig2('Year','Productivity index for Moores Law',1,0);
relabelaxis(log([1/100 1/10 1]),strmat('1/100 1/10 1'),'y');
print(figname,'-dpsc','-append');


% figure(2); figsetup;  makefigwide;
% [ax,h1,h2]=plotyy(years,log(tfp),years,log(sci));
% darkfactor=.8;
% set(h1,'LineWidth',LW,'Color',myblue);
% set(h2,'LineWidth',LW,'Color',mygreen);
% set(ax(1),'ycolor',myblue*darkfactor);
% set(ax(2),'ycolor',mygreen*darkfactor);
% %set(ax(2),'XLim',[1910 2014]);
% %set(ax(1),'XLim',[1910 2014]);
% set(ax(2),'YLim',[0 log(1400)]);
% set(ax(1),'YLim',[log(1/1400) 0]);
% lab2=strmat('1 10 100 1000');
% lab1=strmat('1/1000 1/100 1/10 1');
% %lab=strmat('1960 1970 1980 1990 2000 2010');
%  set(ax(2),'YTick',log(str2num(lab2)));
%  set(ax(2),'YTickLabel',lab2);
%  set(ax(1),'YTick',log(str2num(lab1)));
%  set(ax(1),'YTickLabel',lab1);
% fs=14;
% str=mlstring('Idea TFP (left scale)');
% text(1993,log(1/120),str,'FontSize',fs);
% str=mlstring('Effective number of\\ researchers (right scale)');
% text(2000,log(1/6),str,'FontSize',fs);
% set(ax(1),'Box','off');
% set(ax(2),'Box','off');
% chadfig2(' ','Index (1971=1)',1,0);
% chadfigyy(ax(2),'Index (1971=1)');
% makefigwide
% print SemiconductorTFP.eps;
% print('-dpng','SemiconductorTFP');



% figure(3); figsetup;  makefigwide;
% [ax,h1,h2]=plotyy(years,log(2)/2*100*ones(size(years)),years,log(sci));
% darkfactor=.8;
% set(h1,'LineWidth',LW,'Color',myblue);
% set(h2,'LineWidth',LW,'Color',mygreen);
% set(ax(1),'ycolor',myblue*darkfactor);
% set(ax(2),'ycolor',mygreen*darkfactor);
% %set(ax(2),'XLim',[1910 2014]);
% %set(ax(1),'XLim',[1910 2014]);
% %set(ax(2),'YLim',[0 log(1400)]);
% set(ax(1),'YLim',[0 100]);
% lab2=strmat('1 10 100 1000');
% lab1=strmat('0% 25% 50% 75% 100%');
% %lab=strmat('1960 1970 1980 1990 2000 2010');
%  set(ax(2),'YTick',log(str2num(lab2)));
%  set(ax(2),'YTickLabel',lab2);
%  set(ax(1),'YTick',[0 25 50 75 100]);
%  set(ax(1),'YTickLabel',lab1);
% fs=14;
% str=mlstring('$\dot{A}_{it}/A_{it}$ (left scale)');
% text(1993,40,str,'FontSize',fs,'interpreter','latex');
% str=mlstring('Effective number of\\ researchers (right scale)');
% text(2000,75,str,'FontSize',fs);
% set(ax(1),'Box','off');
% set(ax(2),'Box','off');
% chadfig2(' ','Growth rate',1,0);
% chadfigyy(ax(2),'Index (1971=1)');
% makefigwide
% print SemiconductorTFP2.eps;
% print('-dpng','SemiconductorTFP2');

% Not a log scale!
figure(3); figsetup;  makefigwide;
[ax,h1,h2]=plotyy(tfpyrs,100*tfpgrowth_smooth,rndyrs,sci(:,BaselineMoore));
%h3=line(ax(2),years,sci(:,1),'LineWidth',LW,'Color',mygreen,'LineStyle','--');
darkfactor=.8;
set(h1,'LineWidth',LW,'Color',myblue);
set(h2,'LineWidth',LW,'Color',mygreen);
set(ax(1),'ycolor',myblue*darkfactor);
set(ax(2),'ycolor',mygreen*darkfactor);
%set(ax(2),'XLim',[1910 2014]);
%set(ax(1),'XLim',[1910 2014]);
set(ax(2),'YLim',[0  12]);
set(ax(1),'YLim',[0 100]);
%lab2=strmat('0 250 500 750'); % 1000 1250');
%lab2=strmat(' 1 #10#20#30#40#50#60#70#80#90','#'); % 1000 1250');
lab2=strmat(' 1 # 5 #10#15','#'); % 1000 1250');
lab1=strmat('0% 20% 40% 60% 80% 100%');
%lab1=strmat('0% 25% 50% 75% 100%');
%lab=strmat('1960 1970 1980 1990 2000 2010');
 set(ax(2),'YTick',(str2num(lab2)));
 set(ax(2),'YTickLabel',lab2);
 set(ax(1),'YTick',0:20:100); % 70 105 140]);
 set(ax(1),'YTickLabel',lab1);
fs=14;
str=mlstring('$\dot{A}_{it}/A_{it}$ (left scale)');
text(2000,30,str,'FontSize',fs,'interpreter','latex');
str=mlstring('Effective number of\\ researchers (right scale)');
text(1990,90,str,'FontSize',fs);
set(ax(1),'Box','off');
set(ax(2),'Box','off');
chadfig2(' ','Growth rate',1,0);
chadfigyy(ax(2),'Factor increase since 1971');
makefigwide
%print SemiconductorTFP.eps;
print('-depsc',figname);
print(figname,'-dpsc','-append');



diary off;
