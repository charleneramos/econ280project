% NMEGraph  12/18/14
%
%  New molecular entities and Pharma research
clear;
global MasterCase Lambda;
diarychad('NMEGraph',MasterCase);
run ../ShowMasterParameters
figname='NMEGraph';
if strcmp(MasterCase,'Main')~=1; figname=[figname '_' MasterCase]; end;
definecolors;


% See NME-Since1938.xls
%
data=[
%	Total R&D spending (millions)	NME		
1970	618.5	15
1971	683.8	12
1972	726.1	10
1973	825.0	14
1974	940.8	21
1975	1061.5	20
1976	1163.7	22
1977	1276.1	25
1978	1404.0	17
1979	1626.8	14
1980	1976.7	12
1981	2339.5	27
1982	2773.7	28
1983	3217.6	14
1984	3578.8	22
1985	4077.6	30
1986	4740.1	20
1987	5502.2	21
1988	6537.5	21
1989	7330.0	22
1990	8420.3	23
1991	9705.4	30
1992	11467.9	26
1993	12740.0	25
1994	13449.4	22
1995	15207.4	28
1996	16905.6	53
1997	18958.1	39
1998	20966.9	30
1999	22690.7	35
2000	26030.8	27
2001	29772.7	24
2002	31012.2	17
2003	34453.3	21
2004	37018.1	36
2005	39857.9	20
2006	42973.5	22
2007	47903.1	18
2008	47383.1	24
2009	46441.6	26
2010	50709.8	21
2011	48645.0	30
2012	49600.0	39
2013	51600.0	27
2014	53300.0	41
2015	58800.0	45
];

years=data(:,1);
rnd=data(:,2);
nme=data(:,3);


load ../WageSci/WageScientistData
WageSci=WageScientist(years-WageYears(1)+1);
WageNotes



sci=rnd./WageSci;
sci=sci/sci(1)*1; % Index
sci=sci.^Lambda; % Adjusting effective research by lambda


tfp=nme./sci;
tfp=tfp/tfp(1)*1;


% Compute gA for backing out beta
%A=exp(cumsum(nme));
%gA=mean(delchange(log(A)));

figure(1); figsetup; makefigwide;
%plot(years,nme,'-','Color',myblue,'LineWidth',4);
h=bar(years,nme);
ax=axis; ax(1)=1969; ax(2)=2016; axis(ax);
chadfig2('Year','Number of NMEs approved',1,0);
print('-depsc',[figname '_Output']);

% figure(2); figsetup; makefigwide;
% plot(years,log(tfp),'-','Color',myblue,'LineWidth',4);
% chadfig2('Year','Productivity index for NMEs',1,0);
% relabelaxis(log([1/8 1/4 1/2 1]*100),strmat('1/8 1/4 1/2 1'),'y');
% print NMEGraphTFP.eps

figure(2); figsetup;  makefigwide;
[ax,h1,h2]=plotyy(years,log(tfp),years,log(sci));
darkfactor=.8;
set(h1,'LineWidth',LW,'Color',myblue);
set(h2,'LineWidth',LW,'Color',mygreen);
set(ax(1),'ycolor',myblue*darkfactor);
set(ax(2),'ycolor',mygreen*darkfactor);
%set(ax(2),'XLim',[1910 2014]);
%set(ax(1),'XLim',[1910 2014]);
%set(ax(2),'YLim',[0 log(1300)]);
lab2=strmat('1 2 4 8 16');
lab1=strmat('1/16 1/8 1/4 1/2 1');
relabelaxis(log(str2num(lab1)),lab1,'y',ax(1));
relabelaxis(log(str2num(lab2)),lab2,'y',ax(2));
set(ax(1),'YLim',[log(1/16) log(1.4)]);

fs=14;
str=mlstring('Research productivity\\    (left scale)');
text(1972,log(1/3),str,'FontSize',fs);
str=mlstring('Effective number of\\ researchers (right scale)');
text(1994,log(1.3),str,'FontSize',fs);
set(ax(1),'Box','off');
set(ax(2),'Box','off');
chadfig2(' ','Index (1970=1)',1,0);
chadfigyy(ax(2),'Index (1970=1)');
makefigwide
print('-depsc',[figname '_TFP']);

cshow(' ',[years sci tfp],'%6.0f %12.2f %12.5f','Year Scientists IdeaTFP');

disp ' ';
gSci =100*log(sci(end)/sci(1))/(years(end)-years(1));
giTFP=100*log(tfp(end)/tfp(1))/(years(end)-years(1));
fprintf('The implied average growth rate of scientists is %8.2f percent\n',gSci);
fprintf('The implied average growth rate of idea TFP   is %8.2f percent\n',giTFP);
fprintf('The factor decline in idea TFP is %8.3f\n',1./tfp(end));
fprintf('      Half life of idea TFP = %8.2f years\n',-log(2)/giTFP*100);

%fprintf('     Growth rate of A := exp(cumsum(nme)) = %8.4f\n',gA);
%fprintf('      Implied beta = %8.2f\n',-giTFP/gA);



diary off;
