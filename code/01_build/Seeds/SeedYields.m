% SeedYields.m
%
%  Loads the data from the "Export" tab of the file "Seed Data v?.xlsx"
%  See that file for all the details.
%
% Briefly, here is the structure:
% 4 crops: Corn, Soybeans, Cotton, Wheat
% Columns:
%  (1) = Realized average yields (bushels/acre, except cotton = lb/acre)
%  (2) = Total R&D (seed efficiency only), Sum of public + private
%  (3) = Total R&D (seed efficiency and crop protection), Sum of public + private
%   The R&D units are millions of nominal dollars.
%
% Idea output = Average (smoothed) Seed Yield growth over next 5 years

clear;
global MasterCase Lambda StopForFigLabels;
diarychad('SeedYields',MasterCase);
run ../ShowMasterParameters

SlideFigures=0 % 1  %0

% From Seed data v6.xlsx
data=[%  (1)    (2)     (3)
      %CORN	bushels/acre				SOYBEAN	bushels/acre			COTTON	lb/acre			                WHEAT	bushels/acre		
1960	54.70	NaN	NaN			1960	23.50	NaN	NaN			1960	446.00	NaN	NaN			1960	26.10	NaN	NaN
1961	62.40	NaN	NaN			1961	25.10	NaN	NaN			1961	438.00	NaN	NaN			1961	23.90	NaN	NaN
1962	64.70	NaN	NaN			1962	24.20	NaN	NaN			1962	457.00	NaN	NaN			1962	25.00	NaN	NaN
1963	67.90	NaN	NaN			1963	24.40	NaN	NaN			1963	517.00	NaN	NaN			1963	25.20	NaN	NaN
1964	62.90	NaN	NaN			1964	22.80	NaN	NaN			1964	517.00	NaN	NaN			1964	25.80	NaN	NaN
1965	74.10	NaN	NaN			1965	24.50	NaN	NaN			1965	527.00	NaN	NaN			1965	26.50	NaN	NaN
1966	73.10	NaN	NaN			1966	25.40	NaN	NaN			1966	480.00	NaN	NaN			1966	26.30	NaN	NaN
1967	80.10	NaN	NaN			1967	24.50	NaN	NaN			1967	447.00	NaN	NaN			1967	25.80	NaN	NaN
1968	79.50	NaN	NaN			1968	26.70	NaN	NaN			1968	516.00	NaN	NaN			1968	28.40	NaN	NaN
1969	85.90	7.16	39.18			1969	27.40	2.00	8.71			1969	434.00	2.86	26.40			1969	30.60	2.57	13.21
1970	72.40	NaN	NaN			1970	26.70	NaN	NaN			1970	438.00	NaN	NaN			1970	31.00	NaN	NaN
1971	88.10	NaN	NaN			1971	27.50	NaN	NaN			1971	438.00	NaN	NaN			1971	33.90	NaN	NaN
1972	97.00	NaN	NaN			1972	27.80	NaN	NaN			1972	507.00	NaN	NaN			1972	32.70	NaN	NaN
1973	91.30	NaN	NaN			1973	27.80	NaN	NaN			1973	520.00	NaN	NaN			1973	31.60	NaN	NaN
1974	71.90	NaN	NaN			1974	23.70	NaN	NaN			1974	442.00	NaN	NaN			1974	27.30	NaN	NaN
1975	86.40	NaN	NaN			1975	28.90	NaN	NaN			1975	453.00	NaN	NaN			1975	30.60	NaN	NaN
1976	88.00	NaN	NaN			1976	26.10	NaN	NaN			1976	465.00	NaN	NaN			1976	30.30	NaN	NaN
1977	90.80	NaN	NaN			1977	30.60	NaN	NaN			1977	520.00	NaN	NaN			1977	30.70	NaN	NaN
1978	101.00	NaN	NaN			1978	29.40	NaN	NaN			1978	420.00	NaN	NaN			1978	31.40	NaN	NaN
1979	109.50	NaN	NaN			1979	32.10	NaN	NaN			1979	547.00	NaN	NaN			1979	34.20	NaN	NaN
1980	91.00	NaN	NaN			1980	26.50	NaN	NaN			1980	404.00	NaN	NaN			1980	33.50	NaN	NaN
1981	108.90	NaN	NaN			1981	30.10	NaN	NaN			1981	542.00	NaN	NaN			1981	34.50	NaN	NaN
1982	113.20	NaN	NaN			1982	31.50	NaN	NaN			1982	590.00	NaN	NaN			1982	35.50	NaN	NaN
1983	81.10	NaN	NaN			1983	26.20	NaN	NaN			1983	508.00	NaN	NaN			1983	39.40	NaN	NaN
1984	106.70	65.12	196.84			1984	28.10	25.27	85.23			1984	600.00	10.49	70.54			1984	38.80	20.41	66.90
1985	118.00	NaN	NaN			1985	34.10	NaN	NaN			1985	630.00	NaN	NaN			1985	37.50	NaN	NaN
1986	119.40	NaN	NaN			1986	33.30	NaN	NaN			1986	552.00	NaN	NaN			1986	34.40	NaN	NaN
1987	119.80	NaN	NaN			1987	33.90	NaN	NaN			1987	706.00	NaN	NaN			1987	37.70	NaN	NaN
1988	84.60	NaN	NaN			1988	27.00	NaN	NaN			1988	619.00	NaN	NaN			1988	34.10	NaN	NaN
1989	116.30	NaN	NaN			1989	32.30	NaN	NaN			1989	614.00	NaN	NaN			1989	32.70	NaN	NaN
1990	118.50	NaN	NaN			1990	34.10	NaN	NaN			1990	634.00	NaN	NaN			1990	39.50	NaN	NaN
1991	108.60	NaN	NaN			1991	34.20	NaN	NaN			1991	652.00	NaN	NaN			1991	34.30	NaN	NaN
1992	131.50	NaN	NaN			1992	37.60	NaN	NaN			1992	700.00	NaN	NaN			1992	39.30	NaN	NaN
1993	100.70	NaN	NaN			1993	32.60	NaN	NaN			1993	606.00	NaN	NaN			1993	38.20	NaN	NaN
1994	138.60	183.00	367.56			1994	41.40	64.13	134.54			1994	708.00	45.92	152.61			1994	37.60	49.47	105.18
1995	113.50	217.62	419.27			1995	35.30	72.71	143.49			1995	537.00	52.68	151.85			1995	35.80	51.65	111.62
1996	127.10	276.54	492.85			1996	37.60	86.20	160.75			1996	705.00	64.03	167.69			1996	36.30	55.02	114.62
1997	126.70	346.33	583.10			1997	38.90	104.01	185.06			1997	673.00	75.85	187.34			1997	39.50	59.33	122.93
1998	134.40	435.90	656.04			1998	38.90	125.83	196.29			1998	625.00	91.45	185.85			1998	43.20	62.67	114.17
1999	133.80	473.08	676.13			1999	36.60	139.96	206.89			1999	607.00	96.81	183.98			1999	42.70	64.26	112.30
2000	136.90	520.08	712.77			2000	38.10	150.75	211.64			2000	632.00	103.94	184.93			2000	42.00	67.07	116.30
2001	138.20	515.76	663.30			2001	39.60	151.87	200.20			2001	705.00	102.07	168.78			2001	40.20	65.17	106.22
2002	129.30	530.65	679.37			2002	38.00	159.01	210.74			2002	665.00	104.26	172.61			2002	35.00	67.43	112.39
2003	142.20	532.21	689.53			2003	33.90	160.20	214.22			2003	730.00	105.29	175.31			2003	44.20	69.68	119.90
2004	160.30	567.47	745.30			2004	42.20	172.25	236.37			2004	855.00	111.51	185.28			2004	43.20	71.35	125.27
2005	147.90	575.58	761.47			2005	43.10	175.60	244.00			2005	831.00	113.21	185.71			2005	42.00	71.88	125.58
2006	149.10	658.84	880.90			2006	42.90	194.29	280.18			2006	814.00	127.26	188.69			2006	38.60	77.23	137.80
2007	150.70	727.87	925.92			2007	41.70	214.60	294.59			2007	879.00	139.28	210.62			2007	40.20	77.45	134.50
2008	153.30	884.07	1106.48			2008	39.70	253.94	342.50			2008	813.00	165.97	244.79			2008	44.80	84.76	142.26
2009	164.40	962.83	1209.64			2009	44.00	273.76	371.60			2009	776.00	177.26	256.82			2009	44.30	92.22	153.21
2010	152.60	1084.84	NaN			2010	43.50	298.89	NaN			2010	812.00	200.82	NaN			2010	46.10	97.44	NaN
2011	146.80	1234.76	NaN			2011	42.00	331.06	NaN			2011	790.00	225.68	NaN			2011	43.60	107.26	NaN
2012	123.10	1308.35	NaN			2012	40.00	350.06	NaN			2012	892.00	235.84	NaN			2012	46.20	113.19	NaN
2013	158.10	1342.70	NaN			2013	44.00	355.34	NaN			2013	821.00	241.10	NaN			2013	47.10	113.93	NaN
2014	171.00	1418.92	NaN			2014	47.50	374.47	NaN			2014	838.00	254.74	NaN			2014	43.70	122.76	NaN
2015	168.40	NaN	NaN			2015	48.00	NaN	NaN			2015	766.00	NaN	NaN			2015	43.60	NaN	NaN
];


Years=data(:,1);
Yields=data(:,[2 6 10 14]);
rnd1=data(:,[3 7 11 15]);
rnd2=data(:,[4 8 12 16]);

% Names
CropNames={'Corn','Soybeans','Cotton','Wheat'};
YieldUnits={'bushels/acre','bushels/acre','lbs/acre','bushels/acre'}


% YieldGrowth
% Forward looking growth: growth(2014) = 2014-2015, so matching up with 2014 RND 
HPSmoother=400
YieldsSmoothed=exp(hpfilter(log(Yields),HPSmoother));
YieldGrowth=diff(log(YieldsSmoothed));
AvgYieldGrowth5Years=smooth(YieldGrowth,0,4);
yrs=trimr(Years,0,1);
rnd1=trimr(rnd1,0,1);
rnd2=trimr(rnd2,0,1);

% Effective Scientists: deflate RND by WageSci
load ../WageSci/WageScientistData      % Loads whatever wage deflator we are using as default.
WageSci=WageScientist(yrs-WageYears(1)+1);
WageNotes
EffectiveScientists1=div(rnd1,WageSci)*10^6; % RND is in millions
EffectiveScientists2=div(rnd2,WageSci)*10^6; % RND is in millions

% Adjust for Lambda
EffectiveScientists1=EffectiveScientists1.^Lambda;
EffectiveScientists2=EffectiveScientists2.^Lambda;

% Idea TFP
IdeaTFP1=AvgYieldGrowth5Years./EffectiveScientists1;
IdeaTFP2=AvgYieldGrowth5Years./EffectiveScientists2;
f=find(~isnan(IdeaTFP2(:,1)));
firstyear=f(1);
IdeaTFP1=div(IdeaTFP1,IdeaTFP1(firstyear,:)); % Normalize so takes the value 1 in first year
IdeaTFP2=div(IdeaTFP2,IdeaTFP2(firstyear,:));
Sci1=EffectiveScientists1;
Sci2=EffectiveScientists2;
Sci1=div(Sci1,Sci1(firstyear,:));
Sci2=div(Sci2,Sci2(firstyear,:));
yy=f; %(firstyear:length(IdeaTFP2)); % Year indexes to plot for IdeaTFP

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOT Now we plot the results
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

definecolors
fname='SeedYields'; if exist([fname '.ps']); delete([fname '.ps']); end;
printopt;
LW=3
FS=24;   % FontSize for 2x2 plots for paper
FSb=18 ; % for chadfig2 axis label 
ShrinkSize=.93;
SeedFigName='SeedData_';
YieldFigName='Yields_';
if strcmp(MasterCase,'Main')~=1; 
    SeedFigName=[SeedFigName '_' MasterCase]; 
    YieldFigName=[YieldFigName '_' MasterCase]; 
end;


if SlideFigures==1;
    if Lambda~=1; disp 'Error: Slide figures with Lambda /= 1. Fignames not set up for this.'; keyboard; end;
    FS=16; FSb=10; ShrinkSize=1;  % For slides
    SeedFigName='SeedDataSlides_';
    YieldFigName='YieldsSlides_';
end;

for crop=1:4;

    figure(1); figsetup;
    plot(Years,Yields(:,crop),'-','LineWidth',LW,'Color',myblue);
    plot(Years,YieldsSmoothed(:,crop),'-','LineWidth',LW,'Color',mypurp);
    set(gca,'FontSize',FS);
    chadfig2('  ',YieldUnits{crop},ShrinkSize,0,FSb);
    makefigwide;
    print('-depsc',[YieldFigName CropNames{crop}]);
    title(CropNames{crop});
    print('-dpsc','-append',fname);
    
    figure(1); figsetup;
    plot(yrs,YieldGrowth(:,crop)*100,'-','LineWidth',LW);
    plot(yrs,AvgYieldGrowth5Years(:,crop)*100,'-','LineWidth',LW,'Color',mypurp);
    ax=axis; ax(3)=-0.5; ax(4)=3.5; axis(ax);
    set(gca,'FontSize',FS);
    chadfig2('  ','Yield Growth Rate (percent)',ShrinkSize,0,FSb);
    makefigwide;
    print('-depsc',['YieldGrowth_' CropNames{crop}]);
    title(CropNames{crop});
    print('-dpsc','-append',fname);
    
    figure(1); figsetup;
    plot(yrs(yy),EffectiveScientists1(yy,crop),'-','LineWidth',LW,'Color',myblue);
    plot(yrs(yy),EffectiveScientists2(yy,crop),'-','LineWidth',LW,'Color',mygreen);
    plot(yrs(yy),EffectiveScientists1(yy,crop),'o','LineWidth',LW,'Color',myblue);
    plot(yrs(yy),EffectiveScientists2(yy,crop),'o','LineWidth',LW,'Color',mygreen);
    set(gca,'FontSize',FS);
    chadfig2('  ','# of Researchers',ShrinkSize,0,FSb);
    makefigwide;
    print('-depsc',['Research_' CropNames{crop}]);
    title(CropNames{crop});
    print('-dpsc','-append',fname);

    nums1={0:4:16,0:4:16,0:2:8,0:2:8};
    labs1={'0% 4% 8% 12% 16%','0% 4% 8% 12% 16%','0% 2% 4% 6% 8%','0% 2% 4% 6% 8%'};
    nums={0:6:24,0:6:24,0:4:12,0:2:8};
    labs={'0 6 12 18 24','0 6 12 18 24','0 4 8 12','0 2 4 6 8'};
    
    
    % Seed Basic Data plot
    figure(1); figsetup;  makefigwide;
    [ax,h1,h2]=plotyy(yrs,AvgYieldGrowth5Years(:,crop)*100,yrs(yy),(Sci1(yy,crop)));
    h3=line(ax(2),yrs(yy),Sci2(yy,crop),'LineWidth',LW,'Color',mygreen,'LineStyle','--');
    darkfactor=.8;
    set(h1,'LineWidth',LW,'Color',myblue); %,'Marker','o');
    set(h2,'LineWidth',LW,'Color',mygreen,'Marker','o');
    set(h3,'LineWidth',LW,'Color',mygreen,'Marker','o');
    set(ax(1),'ycolor',myblue*darkfactor);
    set(ax(2),'ycolor',mygreen*darkfactor);
    %relabelaxis(0:4,strmat('0% 1% 2% 3% 4%'),'y',ax(1));
    %relabelaxis(0:4:32,strmat('0 4 8 12 16 20 24 28 32'),'y',ax(2));
    %relabelaxis(0:2:12,strmat('0% 2% 4% 6% 8% 10% 12%'),'y',ax(1));
    relabelaxis(nums1{crop},strmat(labs1{crop}),'y',ax(1));
    relabelaxis(nums{crop},strmat(labs{crop}),'y',ax(2));
    %fs=14;
    str=mlstring('Yield growth, left scale\\ (moving average)');
    text(1970,3.5,str,'FontSize',FS-2);
    str=mlstring('Effective number of\\ researchers (right scale)');
    text(1990,8,str,'FontSize',FS-2);
    set(ax(1),'Box','off');
    set(ax(2),'Box','off');
    set(ax(1),'FontSize',FS);
    set(ax(2),'FontSize',FS);
    if SlideFigures==1;
        chadfig2(' ','Growth rate',ShrinkSize,0);
        chadfigyy(ax(2),'Factor increase since 1969'); %,2.85,2,FSb);
    else;
        chadfig2(' ','Growth rate',ShrinkSize,0,FSb);
        chadfigyy(ax(2),'Factor increase since 1969',2.85,2,FSb);
    end;
    if StopForFigLabels; wait('Adjust fig labels and press any key to continue'); end;
    print('-depsc',[SeedFigName CropNames{crop}]);
    print('-dpsc','-append',fname);
    
    
    
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % IdeaTFP1: Seed efficiency only
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    figure(1); figsetup;  makefigwide;
    [ax,h1,h2]=plotyy(yrs(yy),log2(IdeaTFP1(yy,crop)),yrs(yy),log2(Sci1(yy,crop)));
    darkfactor=.8;
    set(h1,'LineWidth',LW,'Color',myblue,'Marker','o');
    set(h2,'LineWidth',LW,'Color',mygreen,'Marker','o');
    set(ax(1),'ycolor',myblue*darkfactor);
    set(ax(2),'ycolor',mygreen*darkfactor);
    axnum=(-6:3)';
    axlab=strmat('1/64#1/32#1/16# 1/8# 1/4# 1/2# 1 # 2 # 4 # 8 ','#');
    imin=floor(min(log2(IdeaTFP1(:,crop))));  % e.g. -4 ==> 1/16
    imax=ceil(max(log2(IdeaTFP1(:,crop))));  % e.g. 2 ==> 4
    indx=find(axnum==imin);
    ind2=find(axnum==imax);
    relabelaxis(axnum(indx:ind2),axlab(indx:ind2,:),'y',ax(1));
    axnum=(0:5)';
    axlab=strmat(' 1 # 2 # 4 # 8 # 16# 32','#');
    smax=ceil(max(log2(Sci1(:,crop))));  % e.g. 2 ==> 4
    indx=find(axnum==smax);
    relabelaxis(axnum(1:indx),axlab(1:indx,:),'y',ax(2));
    fs=14;
    %str=mlstring('Idea TFP (left scale)');
    %text(1972,log(1/2.6),str,'FontSize',fs);
    %str=mlstring('Effective number of\\ researchers (right scale)');
    %text(1994,log(1.3),str,'FontSize',fs);
    set(ax(1),'Box','off');
    set(ax(2),'Box','off');
    set(ax(1),'FontSize',FS);
    set(ax(2),'FontSize',FS);
    chadfig2(' ','Idea TFP',ShrinkSize,0,FSb);
    chadfigyy(ax(2),'# of Researchers',2.85,2,FSb);
    print('-depsc',['IdeaTFP1_' CropNames{crop}]);
    title(['Seed efficiency only: ' CropNames{crop}]);
    print('-dpsc','-append',fname);


    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % IdeaTFP2: Seed efficiency and crop protection
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    figure(1); figsetup;  makefigwide;
    [ax,h1,h2]=plotyy(yrs(yy),log2(IdeaTFP2(yy,crop)),yrs(yy),log2(Sci2(yy,crop)));
    darkfactor=.8;
    set(h1,'LineWidth',LW,'Color',myblue,'Marker','o');
    set(h2,'LineWidth',LW,'Color',mygreen,'Marker','o');
    set(ax(1),'ycolor',myblue*darkfactor);
    set(ax(2),'ycolor',mygreen*darkfactor);
    axnum=(-6:3)';
    axlab=strmat('1/64#1/32#1/16# 1/8# 1/4# 1/2# 1 # 2 # 4 # 8 ','#');
    imin=floor(min(log2(IdeaTFP2(:,crop))));  % e.g. -4 ==> 1/16
    imax=ceil(max(log2(IdeaTFP2(:,crop))));  % e.g. 2 ==> 4
    indx=find(axnum==imin);
    ind2=find(axnum==imax);
    relabelaxis(axnum(indx:ind2),axlab(indx:ind2,:),'y',ax(1));
    axnum=(0:5)';
    axlab=strmat(' 1 # 2 # 4 # 8 # 16# 32','#');
    smax=ceil(max(log2(Sci2(:,crop))));  % e.g. 2 ==> 4
    indx=find(axnum==smax);
    relabelaxis(axnum(1:indx),axlab(1:indx,:),'y',ax(2));
    fs=14;
    %str=mlstring('Idea TFP (left scale)');
    %text(1972,log(1/2.6),str,'FontSize',fs);
    %str=mlstring('Effective number of\\ researchers (right scale)');
    %text(1994,log(1.3),str,'FontSize',fs);
    set(ax(1),'Box','off');
    set(ax(2),'Box','off');
    %    chadfig2(' ','Index (1969=1)',1,0);
    set(ax(1),'FontSize',FS);
    set(ax(2),'FontSize',FS);
    chadfig2(' ','Idea TFP',ShrinkSize,0,FSb);
    chadfigyy(ax(2),'# of Researchers',2.85,2,FSb);
    print('-depsc',['IdeaTFP2_' CropNames{crop}]);
    title(['Seed efficiency and crop protection: ' CropNames{crop}]);
    print('-dpsc','-append',fname);

    disp ' ';
    disp(CropNames{crop});
    %cshow(' ',[yrs(yy) AvgYieldGrowth5Years(:,crop) Sci1(yy,crop) Sci2(yy,crop) IdeaTFP1(yy,crop) IdeaTFP2(yy,crop)],'%6.0f %12.5f','Year Scientists1 Scientists2 IdeaTFP1 IdeaTFP2');
    cshow(' ',[yrs AvgYieldGrowth5Years(:,crop) Sci1(:,crop) Sci2(:,crop) IdeaTFP1(:,crop) IdeaTFP2(:,crop)],'%6.0f %12.5f','Year AvgYldGrwth Scientists1 Scientists2 IdeaTFP1 IdeaTFP2');
    disp ' ';
    y0=yy(1); yT=yy(end);

    gSci1 =100*log(Sci1(yT,crop)/Sci1(y0,crop))/(yrs(yT)-yrs(y0));
    giTFP1=100*log(IdeaTFP1(yT,crop)/IdeaTFP1(y0,crop))/(yrs(yT)-yrs(y0));
    halflife1=-log(2)/giTFP1*100;
    beta1=-giTFP1/100/mean(AvgYieldGrowth5Years(yy,crop));
    disp 'Seed efficiency only:'    
    fprintf('  The implied average growth rate of scientists is %8.2f percent\n',gSci1);
    fprintf('  The implied average growth rate of idea TFP   is %8.2f percent\n',giTFP1);
    fprintf('  The factor increase in research is %8.3f\n',Sci1(yT,crop));
    fprintf('  The factor decline in idea TFP is %8.3f\n',1./IdeaTFP1(yT,crop));
    fprintf('      Half life of idea TFP = %8.2f years\n',halflife1);
    fprintf('      Implied beta = %8.2f\n',beta1);
    disp ' ';
    cshow(CropNames{crop},[Sci1(yT,crop) gSci1 1./IdeaTFP1(yT,crop) giTFP1],'%8.1f %8.1f %8.1f %8.1f','','latex');
    disp ' ';
    
    gSci2 =100*log(Sci2(yT,crop)/Sci2(y0,crop))/(yrs(yT)-yrs(y0));
    giTFP2=100*log(IdeaTFP2(yT,crop)/IdeaTFP2(y0,crop))/(yrs(yT)-yrs(y0));
    halflife2=-log(2)/giTFP2*100;
    beta2=-giTFP2/100/mean(AvgYieldGrowth5Years(yy,crop));
    disp 'Seed efficiency and crop protection:'
    fprintf('  The implied average growth rate of scientists is %8.2f percent\n',gSci2);
    fprintf('  The implied average growth rate of idea TFP   is %8.2f percent\n',giTFP2);
    fprintf('  The factor increase in research is %8.3f\n',Sci2(yT,crop));
    fprintf('  The factor decline in idea TFP is %8.3f\n',1./IdeaTFP2(yT,crop));
    fprintf('      Half life of idea TFP = %8.2f years\n',halflife2);
    fprintf('      Implied beta = %8.2f\n',beta2);
    disp ' ';
    cshow(CropNames{crop},[Sci2(yT,crop) gSci2 1./IdeaTFP2(yT,crop) giTFP2],'%8.1f %8.1f %8.1f %8.1f','','latex');
    disp ' ';

end;

%save SeedData; % YieldGrowth yrs EffectiveScientists1 EffectiveScientists2
diary off;
