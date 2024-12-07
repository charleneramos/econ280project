% CompustatRead.m    6/13/2016
%
%  Read the compustat/wrds data for mktcap-based idea pf analysis.
%  Raw years = 1950:2015

addpath ('/Users/charleneramos/Documents/Research/Titan/Bloom et al 2020 - Replication Materials/ChadMatlab/');          

diarychad('CompustatRead');

if ~exist('CompustatRawData.mat'); % Takes about 10 minutes to run

%001009,19941031,1994,INDL,C,D,STD,ABSI,000781104,ABS INDUSTRIES INC,USD,5.0520,0.7050,80.6790,,92.1220,92.1220,,,I,3460,,13.7500
%006066,20141231,2014,INDL,C,D,STD,IBM,459200101,INTL BUSINESS MACHINES CORP,USD,990.5240,379.5920,39034.0000,0.0000,92793.0000,92793.0000,5437.0000,5743,A,7370,158919.6706,160.4400

fmts='%s '; fmtf='%f '; 
zz=ones(2,1)*fmts;  fmt1=vector(char(zz)')';
zz=ones(1,1)*fmtf;  fmt2=vector(char(zz)')';
zz=ones(8,1)*fmts;  fmt3=vector(char(zz)')';
zz=ones(8,1)*fmtf;  fmt4=vector(char(zz)')';
zz=ones(1,1)*fmts;  fmt5=vector(char(zz)')';
zz=ones(3,1)*fmtf;  fmt6=vector(char(zz)')';
fmt=[fmt1 fmt2 fmt3 fmt4 fmt5 fmt6]; fmt(end)=[]; % delete last space

[gvkey,datadate,fyear,indfmt,consol,popsrc,datafmt,ticorig,cusip,conm,curcd,csho,emp,ppegt,rdip,revt,sale,xrd,xrdp,costat,sich,mkvalt,prcc_f]...
    =textread('Compustat-WRDS-2016-06-13.csv',fmt,'delimiter',',','headerlines',1,'emptyvalue',NaN);

yr0=min(fyear);
yrT=max(fyear);
fprintf('Years = %4.0f to %4.0f\n',[yr0 yrT]);
StartingYear=1980
T=yrT-StartingYear+1;

% Now go line by line and reshape each variable to TxN
% keeping only StartingYear to end.
allvars=strmat('gvkey,datadate,fyear,indfmt,consol,popsrc,datafmt,ticorig,cusip,conm,curcd,csho,emp,ppegt,rdip,revt,sale,xrd,xrdp,costat,sich,mkvalt,prcc_f',',');
oldvars=strmat('fyear,csho,emp,revt,sale,xrd,sich,mkvalt,prcc_f',',');
newvars=strmat('Year,NumShares,Emp,TotRevenue,Sales,RND,SIC,MkValt,PriceF',',');
NumVars=size(newvars,1);
for i=1:NumVars;
    eval([newvars(i,:) '=[];']);
end;

NumLines=length(fyear);
firm=0; Name=[]; Code=[]; TIC=[];
i=1;
ObswithDuplicateYears=0;
while i<=NumLines;
%while i<=1530;
    company=gvkey(i);
    i1=0;
    years=[]; ivals=[];
    while strcmp(gvkey(i),company);
        if fyear(i)>=StartingYear;
            if i1==0; i1=i; end;
            if ~strcmp(indfmt(i),'FS'); % Throws out duplicate years
                years=[years; fyear(i)];
                ivals=[ivals; i];
            end;
        end;
        i=i+1;
        if i>NumLines; break; end;
    end;
    if length(unique(years))~=length(years);
        ObswithDuplicateYears=ObswithDuplicateYears+1;
        disp(['Duplicate years in ' company conm(i1)]);
    elseif i1>0;
        firm=firm+1;
        Name=[Name; conm(i1)];
        Code=[Code; company];
        TIC=[TIC; ticorig(i1)];
        for v=1:NumVars;
            eval([newvars(v,:) '=[' newvars(v,:) ' NaN*zeros(T,1)];']);
            eval([newvars(v,:) '(years-StartingYear+1,firm)=' oldvars(v,:) '(ivals);']); 
        end;
    end;
    if i>NumLines; break; end;
end;


% Now evaluate the sample size and cut it down based on various criteria:
disp ' ';
fprintf('The starting number of firms with data >= 1980 is %8.0f\n',length(Name)+ObswithDuplicateYears);
fprintf('The number of firms omitted bc Duplicate Years is %8.0f\n',ObswithDuplicateYears);
fprintf('The number of firms without duplicate years is    %8.0f\n',length(Name));

keep1=~all(isnan(RND))';
fprintf('The number of firms not completely missing RND is %8.0f\n',sum(keep1));
keep2=keep1 & (~all(RND==0))';
fprintf('The number of firms with at least one RND>0 is    %8.0f\n',sum(keep2));

% Restrict the number of firms according to keep2:
newvars=strmat('Year,NumShares,Emp,TotRevenue,Sales,RND,SIC,MkValt,PriceF',',');
Year=Year(:,1);
NumShares=NumShares(:,keep2);
Emp=Emp(:,keep2);
TotRevenue=TotRevenue(:,keep2);
Sales=Sales(:,keep2);
RND=RND(:,keep2);
SIC=SIC(:,keep2);
MkValt=MkValt(:,keep2);
PriceF=PriceF(:,keep2);
Name=Name(keep2);
Code=Code(keep2);
TIC=TIC(keep2);

% Replace zeros in Emp and Sales with NaN (so when we take logs)
Emp(Emp==0)=NaN;
Sales(Sales==0)=NaN;

save CompustatRawData Year NumShares Emp TotRevenue Sales RND SIC TIC MkValt PriceF Name Code

end; %if ~exist('CompustatRawData.mat');

clear
global MasterCase
load CompustatRawData




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Deflate nominal MarketCap and Sales using the GDP Implicit Price Deflator
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
years=(1980:2015)';
load GDPDeflator   % PriceIndexYears 1929-2015 PrinceIndexGDP;   2009=100
PriceIndexGDP=PriceIndexGDP(years-PriceIndexYears(1)+1);

% Market Cap, TotRevenue, Sales ==> Real and Growth
MarketCapNominal=NumShares.*PriceF;
MarketCapReal=div(MarketCapNominal,PriceIndexGDP)*100;

TotRevenueNominal=TotRevenue;
TotRevenueReal=div(TotRevenueNominal,PriceIndexGDP)*100;

SalesNominal=Sales;  % Looks like Sales and TotRevenue are identical except for weird accounting years
SalesReal=div(SalesNominal,PriceIndexGDP)*100;
clear Sales TotRevenue;

% WageSci
load ../WageSci/WageScientistData      % Loads whatever wage deflator we are using as default.
CompuStatYears=(1980:2015)';   % Years for RND
WageSci=WageScientist(CompuStatYears-WageYears(1)+1);
WageNotes
EffectiveScientists=div(RND,WageSci)*10^6; % RND is in millions

% Define decade variables
yr1980s=(years>=1980) & (years<1990);
yr1990s=(years>=1990) & (years<2000);
yr2000s=(years>=2000) & (years<2008); % Omit 2008-2009 great recession
yr2010s=(years>=2010) & (years<2016);

yearg=(1981:2015)';
yr1980g=(yearg>=1980) & (yearg<1990);
yr1990g=(yearg>=1990) & (yearg<2000);
yr2000g=(yearg>=2000) & (yearg<2008); % Omit 2008-2009 great recession
yr2010g=(yearg>=2010) & (yearg<2016);

Name=capitalize(Name);

save(['CompustatData_' MasterCase]);
chadtimer
diary off;

