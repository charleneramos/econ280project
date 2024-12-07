% AgIdeaPF February 2018
%
%  See Michael Webb email: https://mail.google.com/mail/u/0/#inbox/160dcf2d00ed64c8
%  and also this google doc: https://docs.google.com/document/d/1DZDGl3tYOjS3QWeLYbVEMxZQIMVQXD-7s2BIDLXDOVY/edit#heading=h.tk6zb1d6i6li
%
%  TFP SOURCE:  See TFP/Ag TFP v1.xlsx 
%  The USDA Economic Research Service maintains indices of agricultural TFP
%  and components, at the national level and by state. Tables available
%  here: https://www.ers.usda.gov/data-products/agricultural-productivity-in-the-us.aspx
%
%
%  US AgR&D SOURCE: See TFP/USDA-ERS-ag_all_research.xls
%
%  Agricultural Research Funding in the Public and Private Sectors,
%  1970-2009 
%  Source: USDA, ERS based on data from National Science
%  Foundation, USDA's Current Research Information System (CRIS), and
%  various private sector data sources. Data are adjusted for inflation
%  using an index for agricultural research spending developed by ERS. See
%  the documentation for details.
%   Downloaded from: https://www.ers.usda.gov/data-products/agricultural-research-funding-in-the-public-and-private-sectors/
%
%  GLOBAL AgR&D: See TFP/GlobalRND-Agriculture.xls
%   Sources -- Public: ASTI GLOBAL ASSESSMENT OF AGRICULTURAL R&D SPENDING
%                      https://www.asti.cgiar.org/globaloverview
%              Private: Fuglie et al 2011
%                       https://www.ers.usda.gov/webdocs/publications/44951/11777_err130_1_.pdf?v=41499
%           Alternative: Pardey et al 2016
%                Shifting Ground: Food and Agricultural R&D Spending Worldwide, 1960-2011*
%                http://www.instepp.umn.edu/sites/default/files/product/downloadable/Pardey%20et%20al%202016%20--%20Shifting%20Ground%20%282SEPT2016%29.pdf


clear;
global MasterCase Lambda StopForFigLabels;
diarychad('AgIdePF',MasterCase);
run ../ShowMasterParameters

tfpdata=[
%Year	Total agricultural output	Total farm inputs	Total factor productivity	Total agricultural output per acre
%Year      Output       TotalInputs          TFP         Output/Acre
1948	1	1	1	1
1949	0.9851015504	1.0134108319	0.9720653455	0.9817440342
1950	0.961016744	1.019130106	0.9429774848	0.9554916183
1951	1.001188979	1.0349608404	0.9673689476	0.9944228885
1952	1.0329057268	1.0373776542	0.9956892001	1.0265355246
1953	1.0493993199	1.0338664494	1.015024059	1.0453925664
1954	1.0480634038	1.006048796	1.041761998	1.0488472073
1955	1.0767995543	1.0407666729	1.0346214788	1.0856041882
1956	1.083184861	1.0402669357	1.0412566466	1.103102773
1957	1.0702002658	1.0324533802	1.0365603778	1.1027832113
1958	1.1301302248	1.037933912	1.0888267661	1.1781130642
1959	1.1594724044	1.0672652762	1.0863956977	1.2195822759
1960	1.1965085566	1.0558962375	1.1331686904	1.2642859668
1961	1.2101367766	1.0360523594	1.1680266597	1.2806883649
1962	1.219760156	1.0497744663	1.1619259138	1.2917652876
1963	1.2635440049	1.0554188051	1.1971967893	1.3400532083
1964	1.2547252655	1.0399703287	1.206501023	1.3350453763
1965	1.2860629696	1.0409443616	1.2354771465	1.3765449922
1966	1.2793572297	1.0504905291	1.2178665054	1.3811953967
1967	1.3215807649	1.0559510025	1.2515550075	1.4427824418
1968	1.3418384398	1.05209868	1.2753921903	1.484866316
1969	1.368407565	1.0505096979	1.3026129771	1.5380755784
1970	1.3472115069	1.0417466204	1.2932237845	1.5402526428
1971	1.4379227059	1.0340017784	1.390638523	1.6720596045
1972	1.4437321727	1.044387698	1.3823718677	1.7042797103
1973	1.5125747264	1.0658245485	1.419159212	1.8057399775
1974	1.4308785183	1.0647737876	1.3438333428	1.7176881045
1975	1.5506416614	1.0456045857	1.4830096221	1.8594814776
1976	1.5584594784	1.085844742	1.4352507482	1.8597680213
1977	1.6319268581	1.0733902572	1.5203481186	1.9374992758
1978	1.6526256661	1.1458368081	1.4422871167	1.9584543883
1979	1.7515769894	1.1799183915	1.4844899461	2.0836425941
1980	1.6937191648	1.1968232136	1.415179072	2.0310994899
1981	1.8440128158	1.1514372003	1.6014879624	2.2334004682
1982	1.8708825819	1.121978842	1.667484726	2.2873944104
1983	1.6082409153	1.1131172771	1.4448081513	1.9802296997
1984	1.8334881371	1.0897494815	1.6824859	2.2692544557
1985	1.9041307296	1.04996093	1.8135253181	2.3667574245
1986	1.8386282237	1.044505527	1.7602857774	2.2952302862
1987	1.8545105572	1.0374450058	1.7875748082	2.3272469173
1988	1.7483333891	1.0316134454	1.6947563033	2.2088403899
1989	1.8910240111	1.0190221843	1.8557240856	2.4071267644
1990	1.9795750409	1.0219816363	1.9369966843	2.5380048942
1991	1.9888419046	1.0351621879	1.9212853095	2.5640465459
1992	2.1038087116	1.0078699914	2.0873810408	2.7192147142
1993	2.0018002736	1.0164373997	1.9694279985	2.5840724901
1994	2.2373809576	1.0467424494	2.1374703576	2.8773770288
1995	2.119777454	1.0794670558	1.9637259355	2.7139053248
1996	2.2218786093	1.0056838431	2.2093211745	2.8338537017
1997	2.3106202211	1.0411214098	2.2193571271	2.9415755806
1998	2.3254592671	1.050707868	2.2132310397	2.9633882609
1999	2.3794639541	1.059911619	2.2449644965	3.043906006
2000	2.3683645634	1.0469887284	2.2620726463	3.0479075321
2001	2.3837930836	1.0258295696	2.3237710768	3.0902356791
2002	2.3376368619	1.0189552256	2.2941507174	3.0535470624
2003	2.400518139	1.0024107558	2.3947449935	3.1576847703
2004	2.5151471152	0.9945630386	2.5288966285	3.3302396893
2005	2.4824475715	1.0063003319	2.4669052495	3.3082295056
2006	2.5002660377	1.0045793973	2.48886852	3.3540826566
2007	2.5458216785	1.0550278794	2.4130373503	3.438978659
2008	2.5642506463	1.0250548396	2.5015741083	3.4812825591
2009	2.5942036118	1.0013084071	2.5908137727	3.531237293
2010	2.5513805224	0.9951551848	2.5638016677	3.4764523557
2011	2.55204732	0.995580824	2.5633753268	3.4782573923
2012	2.540423466	0.9944481266	2.5546063168	3.4627224262
2013	2.7281890521	1.0089635092	2.7039521522	3.5667994979
2014	2.7023917613	1.0633528148	2.5413876971	3.5407370982
2015	2.6966560219	1.071547867	2.5165987492	3.5383431985
];

tfpyrs=tfpdata(:,1);
Y=tfpdata(:,2);
Inputs=tfpdata(:,3);
tfp=tfpdata(:,4);
YperAcre=tfpdata(:,5);

%  Agricultural Research Funding in the Public and Private Sectors,
%  US: 1970-2009 -- millions of nominal US$
%  Global: 1980-2010 -- millions of nominal US$
rnddata=[% US     Global
1970	1004.4    NaN  
1971	1070.5    NaN  
1972	1165.8    NaN  
1973	1245.9    NaN  
1974	1386.5    NaN  
1975	1578.4    NaN  
1976	1738.0    NaN  
1977	2008.6    NaN  
1978	2219.7    NaN  
1979	2481.2    NaN  
1980	2821.4    10177
1981	3097.9    NaN  
1982	3493.4    NaN  
1983	3685.8    NaN  
1984	4026.4    NaN  
1985	4183.3    NaN  
1986	4520.2    NaN  
1987	4595.8    NaN  
1988	4775.9    NaN  
1989	5031.2    NaN  
1990	5449.1    NaN  
1991	5579.8    NaN  
1992	5811.3    NaN  
1993	5808.9    NaN  
1994	6248.9    24618
1995	6646.3    25478
1996	6964.4    26633
1997	7651.2    27187
1998	7956.6    28318
1999	7547.6    29266
2000	7838.3    30070
2001	8282.0    31150
2002	8898.8    32170
2003	9065.9    33802
2004	10101.2   35022
2005	10723.7   36808
2006	11324.3   39037
2007	11281.8   41701
2008     NaN      44105
2009     NaN      46729
2010     NaN      49532
];

rndyrs=rnddata(:,1);
agrnd=rnddata(:,2:3);
yrs=rndyrs;


% TFPGrowth
% Forward looking growth: growth(2014) = 2014-2015, so matching up with 2014 RND 
HPSmoother=400
TFPSmoothed=exp(hpfilter(log(tfp),HPSmoother));
TFPGrowth=diff(log(TFPSmoothed));
AvgTFPGrowth5Years=smooth(TFPGrowth,0,4); % Moving average of *next five years*
AvgTFPGrowth5YearsTrimmed=AvgTFPGrowth5Years(yrs-tfpyrs(1)+1);
gtfpyrs=trimr(tfpyrs,1,0);

% Effective Scientists: deflate RND by WageSci
load ../WageSci/WageScientistData      % Loads whatever wage deflator we are using as default.
WageSci=WageScientist(rndyrs-WageYears(1)+1);
WageNotes
EffectiveScientists1=div(agrnd(:,1),WageSci)*10^6; % RND is in millions
EffectiveScientists2=div(agrnd(:,2),WageSci)*10^6; % RND is in millions
                                             
% Adjust for Lambda
EffectiveScientists1=EffectiveScientists1.^Lambda;
EffectiveScientists2=EffectiveScientists2.^Lambda;

% Idea TFP
IdeaTFP1=AvgTFPGrowth5YearsTrimmed./EffectiveScientists1;
f=find(~isnan(IdeaTFP1(:,1)));
firstyear=f(1);
IdeaTFP1=div(IdeaTFP1,IdeaTFP1(firstyear,:)); % Normalize so takes the value 1 in first year
Sci1=EffectiveScientists1;
Sci1=div(Sci1,Sci1(firstyear,:));
yy=f; %(firstyear:length(IdeaTFP1)); % Year indexes to plot for IdeaTFP

IdeaTFP2=AvgTFPGrowth5YearsTrimmed./EffectiveScientists2;
f=find(~isnan(IdeaTFP2(:,1)));
firstyear=f(1);
IdeaTFP2=div(IdeaTFP2,IdeaTFP2(firstyear,:)); % Normalize so takes the value 1 in first year
Sci2=EffectiveScientists2;
Sci2=div(Sci2,Sci2(firstyear,:));
yy2=f; %(firstyear:length(IdeaTFP2)); % Year indexes to plot for IdeaTFP


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOT Now we plot the results
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

definecolors
fname='AgTFPFigures'; if exist([fname '.ps']); delete([fname '.ps']); end;
FigName='AgIdeaTFP';
printopt;
LW=3
FS=14
if strcmp(MasterCase,'Main')~=1; 
    FigName=[FigName '_' MasterCase]; 
    fname=[fname '_' MasterCase]; 
end;

figure(1); figsetup;
plot(tfpyrs,tfp,'-','LineWidth',LW,'Color',myblue);
plot(tfpyrs,TFPSmoothed,'-','LineWidth',LW,'Color',mypurp);
set(gca,'FontSize',FS);
chadfig2('  ','TFP',1,0);
makefigwide;
print('-dpsc','-append',fname);

figure(2); figsetup;
plot(gtfpyrs,TFPGrowth*100,'-','LineWidth',LW);
plot(gtfpyrs,AvgTFPGrowth5Years*100,'-','LineWidth',LW,'Color',mypurp);
%ax=axis; ax(3)=-0.5; ax(4)=3.5; axis(ax);
chadfig2('  ','TFP Growth Rate (percent)',1,0);
makefigwide;
print('-dpsc','-append',fname);
    
% Seed Basic Data plot
figure(3); figsetup;  makefigwide;
[ax,h1,h2]=plotyy(gtfpyrs,AvgTFPGrowth5Years*100,rndyrs(yy),(Sci1(yy)));
h3=line(ax(2),rndyrs(yy2),Sci2(yy2),'LineWidth',LW,'Color',mygreen,'LineStyle','-');
darkfactor=.8;
set(h1,'LineWidth',LW,'Color',myblue); %,'Marker','o');
set(h2,'LineWidth',LW,'Color',mygreen); %,'Marker','o');
set(h3,'LineWidth',LW,'Color',mygreen,'Marker','o');
set(ax(1),'ycolor',myblue*darkfactor);
set(ax(2),'ycolor',mygreen*darkfactor);
%relabelaxis(0:4,strmat('0% 1% 2% 3% 4%'),'y',ax(1));
%relabelaxis(0:4:32,strmat('0 4 8 12 16 20 24 28 32'),'y',ax(2));
%relabelaxis(0:2:12,strmat('0% 2% 4% 6% 8% 10% 12%'),'y',ax(1));
%fs=14;
str=mlstring('TFP growth, left scale\\ (next 5 years)');
text(1955,2,str,'FontSize',FS-1);
%str=mlstring('Effective number of\\ U.S. researchers (right scale)');
%text(1975,3.5,str,'FontSize',FS-1);
%str=mlstring('Effective number of\\ global researchers (right scale)');
%text(1975,5.5,str,'FontSize',FS-1);
str=mlstring('U.S. researchers\\ (1970=1, right scale)');
text(1985,3.65,str,'FontSize',FS-1);
str=mlstring('Global researchers\\ (1980=1, right scale)');
text(1992,0.4,str,'FontSize',FS-1);
set(ax(1),'Box','off');
set(ax(2),'Box','off');
set(ax(1),'FontSize',FS);
set(ax(2),'FontSize',FS);
set(ax(2),'YLim',[0.9 2])
set(ax(2),'XLim',[1947 2015])
set(ax(1),'XLim',[1947 2015])
chadfig2(' ','Growth rate',1,0);
chadfigyy(ax(2),'Factor increase',2,2);
set(get(ax(2),'YLabel'),'FontName','Helvetica');
%if StopForFigLabels; wait('Adjust fig labels and press any key to continue'); end;
print('-depsc',FigName);
print('-dpsc','-append',fname);



disp ' ';
disp 'US R&D Data:';
cshow(' ',[yrs(yy) AvgTFPGrowth5YearsTrimmed(yy)*100 Sci1(yy) IdeaTFP1(yy) Sci2(yy) IdeaTFP2(yy)],'%6.0f %12.5f','Year TFPGrowth Scientists1 IdeaTFP1');
disp ' ';
disp 'Global R&D Data:';
cshow(' ',[yrs(yy2) AvgTFPGrowth5YearsTrimmed(yy2)*100 Sci2(yy2) IdeaTFP2(yy2)],'%6.0f %12.5f','Year TFPGrowth Scientist2 IdeaTFP2');
disp ' ';
y0=yy(1); yT=yy(end);

gSci1 =100*log(Sci1(yT)/Sci1(y0))/(yrs(yT)-yrs(y0));
giTFP1=100*log(IdeaTFP1(yT)/IdeaTFP1(y0))/(yrs(yT)-yrs(y0));
halflife1=-log(2)/giTFP1*100;
gTFP=mean(AvgTFPGrowth5YearsTrimmed(yy));
beta1=-giTFP1/100/gTFP;
disp 'US research only:';
fprintf('  The implied average growth rate of scientists is %8.2f percent\n',gSci1);
fprintf('  The implied average growth rate of idea TFP   is %8.2f percent\n',giTFP1);
fprintf('  Average growth rate of Agr TFP is %8.2f percent\n',gTFP*100);
fprintf('  The factor increase in research is %8.3f\n',Sci1(yT));
fprintf('  The factor decline in idea TFP is %8.3f\n',1./IdeaTFP1(yT));
fprintf('      Half life of idea TFP = %8.2f years\n',halflife1);
fprintf('      Implied beta = %8.2f\n',beta1);
disp ' ';

y0=yy2(1); yT=yy2(end);
gSci2 =100*log(Sci2(yT)/Sci2(y0))/(yrs(yT)-yrs(y0));
giTFP2=100*log(IdeaTFP2(yT)/IdeaTFP2(y0))/(yrs(yT)-yrs(y0));
halflife2=-log(2)/giTFP2*100;
gTFP=mean(AvgTFPGrowth5YearsTrimmed(yy));
beta2=-giTFP2/100/gTFP;
disp 'Global research:';
fprintf('  The implied average growth rate of scientists is %8.2f percent\n',gSci2);
fprintf('  The implied average growth rate of idea TFP   is %8.2f percent\n',giTFP2);
fprintf('  Average growth rate of Agr TFP is %8.2f percent\n',gTFP*100);
fprintf('  The factor increase in research is %8.3f\n',Sci2(yT));
fprintf('  The factor decline in idea TFP is %8.3f\n',1./IdeaTFP2(yT));
fprintf('      Half life of idea TFP = %8.2f years\n',halflife2);
fprintf('      Implied beta = %8.2f\n',beta2);
disp ' ';

diary off;