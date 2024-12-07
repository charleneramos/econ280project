function []=mortality(CaseName,FiveYearSurvRate,MortalityRate_uncond,yrs,Publications,Trials,pubyrs,PubScaleString,TFPScaleString,TextLocations,HighQualityFigures);

% Idea TFP for mortality. 
%   This is the generic program that takes the data (for whatever cause)
%   and generates the key results and graphs.
%
%   CaseName -- for naming graphs/logs/etc. e.g 'BreastCancer'
%   FiveYearSurvRate -- fraction surviving 5 years conditional on getting the disease
%   MortalityRate_uncond -- this is the unconditional fraction of people dying from the disease
%   Publications -- # of Publications with disease as a keyword
%   Trials  -- # of Trials with disease as a keyword
%   yrs = the years for all variables except publications/trials (the data should already be in this form)
%   pubyrs = the years for publications/trials
%   PubScaleString = '25 100 400 1600 6400 25600 102400'
%
% Note: For Breast Cancer, I initially used the U.S. mortality rate data. I was surprised that
%  the death rate from breast cancer *rose* betwen 1975 and the early 1990s. It turns out the
%  same thing is true for All Cancer mortality as well. My interpretation of this is that 
%  mortality from other causes fell enough that now people are living long enough to actually *get* cancer,
%  whereas before they were not. So # of deaths could rise even though the mortality rate *conditional* on 
%  getting cancer could fall.
%
%  Now I'm using 5-year survival rates to measure "Probabilit of Death conditional on getting Cancer"
%  and using that as the death rate to plug into our calculation. Should be better, I think...
%
% For HeartDisease, we do not want to condition on getting the illness,
% since a lot of the decline comes from reductions in this. So pass [] for
% FiveYearSurvRate and do not use it.
%
definecolors;
if exist('HighQualityFigures')~=1; HighQualityFigures=0; end;
if exist('TextLocations')~=1; TextLocations=NaN*ones(3,2); end;
yr0=yrs(1)-1;

if ~isempty(FiveYearSurvRate);
    SmoothedSurvRate=hpfilter(FiveYearSurvRate,100);
    figure(2); figsetup;
    plot(yrs,SmoothedSurvRate,'--','Color',mygreen,'LineWidth',LW); hold on
    plot(yrs,FiveYearSurvRate,'Color',myblue,'LineWidth',LW); 
    chadfig2('Year','5-Year Survival Rate',1,0);
    makefigwide;
    if HighQualityFigures; wait; end;
    print('-depsc',[CaseName '_SmoothedSurvRate']); 
    print('-dpsc','-append',CaseName);
else;
    SmoothedMortRate=hpfilter(MortalityRate_uncond,100);
    figure(2); figsetup;
    plot(yrs,MortalityRate_uncond,'--','Color',mygreen,'LineWidth',LW); hold on
    plot(yrs,SmoothedMortRate,'Color',myblue,'LineWidth',LW); 
    chadfig2('Year','Mortality Rate',1,0);
    makefigwide;
    if HighQualityFigures; wait; end;
    print('-depsc',[CaseName '_SmoothedMortRate']); 
    print('-dpsc','-append',CaseName);
    
end;


% Basic mortality statistics for all causes of death, both sexes
% from Mortality.org -- see BasicLifeTable.m
% qx_AllCauses_50over qx_AllCauses_65over YearsAllCauses ex_50over ex_65over
%  Mortality rate qx is a death rate per person, i.e. something like 0.02
load BasicLifeTable % Starts in 1933
load BasicLifeTableWomen % For Breast Cancer
gyrs=trimr(yrs,0,1);

% For Cancer/Breast Cancer:
%  Convert 5-year survival rate into an average mortality rate (not annualized)
%  What is the probability that this incident of cancer kills you?
%  For this calculation, we treat the death as being realized immediately rather than 
%  over the course of 5 years.
% For Heart Disease, just use the crude death rate
if ~isempty(FiveYearSurvRate);
    DeathRate = -log(SmoothedSurvRate); % Convert Smoothed Rate to a mortality rate
else;
    DeathRate = SmoothedMortRate/100000;
end;
deathrate_i=DeathRate; % 50+  Condtional on getting cancer
gdeath=delta(log(deathrate_i));


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YearsLifeSaved Calculations
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% With Constant Probability of Death -- generalizes to Vaupel and Canudas (2003)!
if strncmp(CaseName,'Cancer',6);
    qx_All=qx_AllCauses_50over;
    ex    =ex_50over;
elseif strncmp(CaseName,'BreastCancer',6);
    qx_All=qx_AllCauses_50over_women;
    ex    =ex_50over_women;
elseif strncmp(CaseName,'HeartDisease',6);
    qx_All=qx_AllCauses_65_74;
    ex    =ex_65_74;
end;
mortalityrate_all=qx_All(gyrs-1932)*100000;  % to make it per 100,000
share=MortalityRate_uncond(gyrs-yr0)./mortalityrate_all;
LE=ex(gyrs-1932);
YearsLifeSaved=share.*LE.*(-gdeath);


printopt;
figure(3); figsetup; makefigwide;
[ax,h1,h2]=plotyy(yrs,DeathRate,gyrs,YearsLifeSaved*1000);
darkfactor=.8;
set(h1,'LineWidth',LW,'Color',myblue);
set(h2,'LineWidth',LW,'Color',mygreen);
set(ax(1),'ycolor',myblue*darkfactor);
set(ax(2),'ycolor',mygreen*darkfactor);
%set(ax(2),'XLim',[1910 2014]);
%set(ax(1),'XLim',[1910 2014]);
%set(ax(2),'YLim',[8 40]);
%set(ax(1),'YLim',[0 100]);
fs=14;
str=mlstring('Years of life saved\\  per 1000 people (right scale)');
if isnan(TextLocations(1,1));
    TextLocations(1,1)=1994; TextLocations(1,2)=1979;
end;
text(TextLocations(1,1),1.1*DeathRate(TextLocations(1,2)-yr0),str,'FontSize',fs);
str=mlstring('Mortality rate\\   (left scale)');
if isnan(TextLocations(2,1));
    TextLocations(2,1)=1998; TextLocations(2,2)=2000;
end;
text(TextLocations(2,1),DeathRate(TextLocations(2,2)-yr0),str,'FontSize',fs);
set(ax(1),'Box','off');
set(ax(2),'Box','off');
chadfig2(' ','Death Rate',1,0);
chadfigyy(ax(2),'Years');
if HighQualityFigures; wait; end;
print('-depsc',[CaseName '_Output']); 
print('-dpsc','-append',CaseName);


pubyr0=pubyrs(1)-1;
figure(4); figsetup;
h=plotlog(pubyrs,Publications,'-',PubScaleString); % 
set(h,'LineWidth',LW);
hold on;
plot(pubyrs,log(Trials),'Color',mygreen,'LineWidth',LW);
chadfig2('Year','Research effort',1,0);
makefigwide;
text(1982,log(Publications(2010-pubyr0)),'Number of publications');
text(1995,log(Trials(1983-pubyr0)),'Number for clinical trials');
if HighQualityFigures; wait; end;
print('-depsc',[CaseName '_Publications']); 
print('-dpsc','-append',CaseName);


Publications=Publications(gyrs-pubyr0);
Trials=Trials(gyrs-pubyr0);

TFPPublications=YearsLifeSaved./Publications*1e7;
TFPTrials=YearsLifeSaved./Trials*100000;

disp ' ';
fmt='%6.0f %8.3f %8.4f %8.0f %8.0f %8.3f %8.2f %8.1f %8.0f %8.0f %8.2f %8.2f';
tle='Years DeathRate gDeath Mort_i Allmort ShareC LE YrsSavd Pubs Trials TFPpub TFPtri';
cshow(' ',[gyrs deathrate_i(gyrs-yr0) gdeath(gyrs-yr0) MortalityRate_uncond(gyrs-yr0) mortalityrate_all share LE YearsLifeSaved*1000 Publications Trials TFPPublications TFPTrials],fmt,tle);

disp ' ';
disp 'YrsSaved = Years of Life Saved per 1000 people';
disp 'TFPPublications  = Years of Life Saved per 100,000 people by each 100 publications';
disp 'TFPTrials = Years of Life Saved per 100,000 people by each clinical trial';

disp ' ';
years=gyrs;
gPub =100*log(Publications(end)/Publications(1))/(years(end)-years(1));
giTFPpub=100*log(TFPPublications(end)/TFPPublications(1))/(years(end)-years(1));
fprintf('The implied average growth rate of Pubs is %8.2f percent\n',gPub);
fprintf('The factor increase of Publications is %8.3f\n',Publications(end)/Publications(1));
fprintf('The implied average growth rate of idea TFP (pubs) is %8.2f percent\n',giTFPpub);
fprintf('The factor decline of idea TFP (pubs) is %8.3f\n',TFPPublications(1)/TFPPublications(end));
fprintf('      Half life of idea TFP (pubs)   = %8.2f years\n',-log(2)/giTFPpub*100);
disp ' ';
gTrial =100*log(Trials(end)/Trials(1))/(years(end)-years(1));
giTFPtrial=100*log(TFPTrials(end)/TFPTrials(1))/(years(end)-years(1));
fprintf('The implied average growth rate of Trials is %8.2f percent\n',gTrial);
fprintf('The factor increase of Trials is %8.3f\n',Trials(end)/Trials(1));
fprintf('The implied average growth rate of idea TFP (trials) is %8.2f percent\n',giTFPtrial);
fprintf('The factor decline of idea TFP (trials) is %8.3f\n',TFPTrials(1)/TFPTrials(end));
fprintf('      Half life of idea TFP (trials) = %8.2f years\n',-log(2)/giTFPtrial*100);

disp ' ';
disp 'In latex format...'
fmt='%8.1f';
cshow('Pubs:  ',[Publications(end)/Publications(1) gPub TFPPublications(1)/TFPPublications(end) giTFPpub],fmt,[],'latex');
cshow('Trials:',[Trials(end)/Trials(1) gTrial TFPTrials(1)/TFPTrials(end) giTFPtrial],fmt,[],'latex');



figure(7); figsetup;
plot(gyrs,gdeath(gyrs-yr0)*100,'-','Color',myblue);
plot(gyrs,share*100,'-','Color',myred);
plot(gyrs,LE,'-','Color',mygreen);
chadfig('Year','gdeath, share, and LE',1,0);


% Linear scale for idea TFP
figure(5); figsetup;
%plot(yrs,0*ones(length(yrs)),'-','Color',mygrey,'LineWidth',2); hold on;
plot(gyrs,TFPTrials,'-','Color',mygreen,'LineWidth',LW); 
plot(gyrs,TFPPublications,'-','Color',myblue,'LineWidth',LW); 
ax=axis; ax(1)=min(gyrs); axis(ax);  % Or 1980??
chadfig2('Year','Years of life saved per 100,000 people',1,0);
makefigwide
text(1989,TFPTrials(1987-yr0),mlstring('Per clinical trial'));
text(1995,TFPPublications(1992-yr0),mlstring('Per 100 publications'));
set(gca,'Layer','top');
if HighQualityFigures; wait; end;
%print('-depsc',[CaseName '_TFP']); 
print('-dpsc','-append',CaseName);


% Log scale version of idea TFP
figure(6); figsetup;
%h=plotlog(gyrs,TFPPublications,'-',TFPScaleString); %'Color',myblue,'LineWidth',LW); 
%set(h,'LineWidth',LW);
h=plot(gyrs,log2(TFPPublications),'-','Color',myblue,'LineWidth',LW);
plot(gyrs,log2(TFPTrials),'-','Color',mygreen,'LineWidth',LW); 
%plot(gyrs,TFPPublications,'-','Color',myblue,'LineWidth',LW); 
ax=axis; ax(1)=min(gyrs); axis(ax);
axnum=(-1:11)';
axlab=strmat('1/2# 1 # 2 # 4 # 8 # 16# 32# 64#128#256#512#1024#2048','#');
imin=floor(min(log2(TFPTrials)));  % e.g. -4 ==> 1/16
imax=ceil(max(log2(TFPPublications)));  % e.g. 6 ==> 64
indx=find(axnum==imin);
ind2=find(axnum==imax);
relabelaxis(axnum(indx:ind2),axlab(indx:ind2,:),'y');
chadfig2('Year','Years of life saved per 100,000 people',1,0);
makefigwide
text(1985,log2(0.9*TFPTrials(1995-yr0)),mlstring('Per clinical trial'));
text(1995,log2(1.3*TFPPublications(1995-yr0)),mlstring('Per 100 publications'));
set(gca,'Layer','top');
if HighQualityFigures; wait; end;
print('-depsc',[CaseName '_TFP']); 
print('-dpsc','-append',CaseName);

