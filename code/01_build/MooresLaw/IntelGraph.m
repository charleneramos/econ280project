% IntelGraph
%
%   July 2017 -- See MooresLawRND-2017-07-31.xls
%   for data details.
%
% Nominal data, in millions of dollars


clear;
global MasterCase Lambda;
diarychad('IntelGraph',MasterCase);
run ../ShowMasterParameters
figname='IntelGraph';
if strcmp(MasterCase,'Main')~=1; figname=[figname '_' MasterCase]; end;

definecolors;


% Nominal data, in millions of dollars
version={'Narrow','Narrow (half)','Broad','Broad (half)','Intel only','Intel+AMD'};
BaselineMoore=3  % Baseline case for plotting
version(3)
data=[
%	       Narrow		   Broad			
%	Total	    With Half	   Total	With Half		
%	(include    Weight for	   (include	Weight for		Intel plus
%  Year	equipment)  Conglomerates  equipment)	Conglomerates	Intel	  AMD
%         (1)          (2)           (3)          (4)            (5)      (6)
%1970	319.34	181.82	373.06	235.55	0.00	0.00
1971	355.99	199.39	408.22	251.62	0.56	0.56
1972	442.02	248.40	506.05	312.43	1.32	1.35
1973	535.55	310.15	626.95	401.55	1.78	1.86
1974	642.43	374.91	753.13	485.61	4.11	4.24
1975	681.19	394.84	788.69	502.34	5.64	5.84
1976	768.97	443.16	897.98	572.16	7.89	8.55
1977	944.90	550.08	1105.31	710.49	10.45	11.41
1978	1117.18	661.92	1328.91	873.65	15.22	16.93
1979	1195.14	721.03	1469.94	995.83	24.24	29.16
1980	1410.68	862.73	1765.03	1217.08	34.73	41.33
1981	1603.01	963.53	2005.13	1365.65	41.75	50.67
1982	2043.46	1194.91	2496.43	1647.88	46.63	61.37
1983	2423.70	1417.81	2997.66	1991.68	50.32	73.00
1984	3126.63	1825.53	3912.65	2610.32	62.79	101.33
1985	3361.98	1958.16	4183.44	2776.77	66.32	111.06
1986	3941.53	2250.21	4784.63	3092.13	74.46	119.70
1987	4529.71	2575.65	5521.93	3565.88	80.12	143.21
1988	4866.31	2776.51	5964.57	3871.57	91.55	145.66
1989	5082.39	2912.75	6227.64	4051.31	96.64	150.17
1990	5667.24	3236.91	6949.13	4508.69	124.23	179.76
1991	6121.82	3471.63	7574.13	4914.60	133.25	193.96
1992	6387.70	3645.57	8026.26	5272.54	149.59	217.99
1993	6669.70	3842.15	8644.04	5803.20	165.39	250.01
1994	7306.01	4269.19	9602.78	6547.22	170.09	267.92
1995	7922.72	4853.22	10830.98	7733.01	181.83	333.42
1996	7752.22	5049.87	11576.71	8832.12	238.29	404.87
1997	8267.69	5585.32	12909.85	10181.30	298.07	508.80
1998	8615.32	5888.38	13744.92	10957.26	334.52	608.29
1999	9367.62	6459.84	15368.10	12387.40	440.68	764.61
2000	10449.63	7657.11	19234.53	16343.68	513.97	853.93
2001	10820.50	8250.70	19331.89	16632.82	526.41	879.02
2002	10767.79	8215.43	19536.23	16746.22	548.91	993.20
2003	10841.56	8259.28	20343.44	17476.28	603.24	1060.81
2004	11292.98	8732.23	22127.74	19258.60	666.05	1151.28
2005	11315.25	8841.85	22958.29	20182.11	715.67	1277.61
2006	13215.84	10790.82	28690.79	25910.81	806.36	1541.16
2007	13148.85	10587.78	27940.97	24902.81	772.32	1521.65
2008	13190.82	10681.67	30338.22	26665.28	742.14	1388.02
2009	11825.88	9438.62	27912.31	24539.87	701.54	1194.60
2010	13070.94	10473.64	30902.75	27351.37	775.97	1084.93
2011	14068.73	11355.37	34798.92	31036.27	934.37	1155.37
2012	14394.48	11701.93	38020.40	34189.61	1075.69	1189.69
2013	15539.00	12590.44	41152.74	36912.03	1065.34	1085.04
2014	16544.63	13470.39	44595.87	39701.27	1158.31	1175.90
%2015	15750.74	12724.54	43937.05	38862.52	1217.65	1233.18
];


years=data(:,1);
rnd=data(:,2:7);

%load RNDSalaries   % YearsWR WageResearch
%sci=rnd./WageResearch(years-1949);
load ../WageSci/WageScientistData
WageSci=WageScientist(years-WageYears(1)+1);
WageNotes

sci=div(rnd,WageSci);
sci=div(sci,sci(1,:)); % Index
sci=sci.^Lambda; % Adjusting effective research by lambda


gmoore=log(2)/2   % doubles every 2 years == transistor counts
Moore=100*exp(gmoore*(years-years(1)));

tfp=1./sci;
tle='Year Narrow Broad MooreNrw MooreBroad Intel IntelAMD';
disp ' '; disp ' ';
disp 'Effective RND:'
cshow(' ',[years sci],'%6.0f %12.2f',tle);
disp ' '; disp ' ';
disp 'IDEA TFP:'
cshow(' ',[years sci],'%6.0f %12.2f',tle);

disp ' ';
gSci =100*log(sci(end,:)./sci(1,:))/(years(end)-years(1));
giTFP=100*log(tfp(end,:)./tfp(1,:))/(years(end)-years(1));
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
plot(years,log(tfp),'-','LineWidth',4);
chadfig2('Year','Productivity index for Moores Law',1,0);
relabelaxis(log([1/100 1/10 1]),strmat('1/100 1/10 1'),'y');


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
% print IntelGraph.eps;
% print('-dpng','IntelGraph');



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
% print IntelGraph2.eps;
% print('-dpng','IntelGraph2');

% Not a log scale!
figure(3); figsetup;  makefigwide;
[ax,h1,h2]=plotyy(years,log(2)/2*100*ones(size(years)),years,sci(:,BaselineMoore));
%h3=line(ax(2),years,sci(:,1),'LineWidth',LW,'Color',mygreen,'LineStyle','--');
darkfactor=.8;
set(h1,'LineWidth',LW,'Color',myblue);
set(h2,'LineWidth',LW,'Color',mygreen);
set(ax(1),'ycolor',myblue*darkfactor);
set(ax(2),'ycolor',mygreen*darkfactor);
%set(ax(2),'XLim',[1910 2014]);
%set(ax(1),'XLim',[1910 2014]);
set(ax(2),'YLim',[0  20]);
set(ax(1),'YLim',[0 140]);
%lab2=strmat('0 250 500 750'); % 1000 1250');
%lab2=strmat(' 1 #10#20#30#40#50#60#70#80#90','#'); % 1000 1250');
lab2=strmat(' 1 # 5 #10#15#20','#'); % 1000 1250');
lab1=strmat('0% 35% 70% 105% 140%');
%lab1=strmat('0% 25% 50% 75% 100%');
%lab=strmat('1960 1970 1980 1990 2000 2010');
 set(ax(2),'YTick',(str2num(lab2)));
 set(ax(2),'YTickLabel',lab2);
 set(ax(1),'YTick',[0 35]); % 70 105 140]);
 set(ax(1),'YTickLabel',lab1);
fs=14;
str=mlstring('$\dot{A}_{it}/A_{it}$ (left scale)');
text(1977,40,str,'FontSize',fs,'interpreter','latex');
str=mlstring('Effective number of\\ researchers (right scale)');
text(1995,110,str,'FontSize',fs);
set(ax(1),'Box','off');
set(ax(2),'Box','off');
chadfig2(' ','Growth rate',1,0);
chadfigyy(ax(2),'Factor increase since 1971');
makefigwide
%print IntelGraph.eps;
print('-depsc',figname);



diary off;
