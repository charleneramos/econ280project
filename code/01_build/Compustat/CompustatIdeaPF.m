% CompustatIdeaPF.m    6/13/2016
%
%  The IdeaPF calculations using the Compustat Data
%  (already read in using CompustatRead)


global CaseName MasterCase Lambda StopForFigLabels;
diarychad(['CompustatIdeaPF_' CaseName],MasterCase);
run ../ShowMasterParameters
figname=['Compustat_' CaseName];
if strcmp(MasterCase,'Main')~=1; figname=[figname '_' MasterCase]; end;

load(['CompustatData_' MasterCase]);
ShowParameters
definecolors;

fnamegraphs=[figname '.ps'];
if exist(fnamegraphs); delete(fnamegraphs); end;


[T,NN]=size(EffectiveScientists);
fprintf('The starting number of firms (some RND after 1980) is %8.0f\n',NN);


% -----------------------------------------------------------------
% Assign "idea output" measure based on the OutputMeasure string
% -----------------------------------------------------------------
if strcmp(OutputMeasure,'MktCap');
    IdeaOutput=MarketCapReal;
    IdeaOutputString='Market Cap (millions)';
    IdeaGrowthString='Market Cap Growth (percent)';
elseif strcmp(OutputMeasure,'Sales');
    IdeaOutput=SalesReal;
    IdeaOutputString='Sales (billions)';
    IdeaGrowthString='Sales Growth (percent)';
elseif strcmp(OutputMeasure,'Emp');
    IdeaOutput=Emp*1000;
    IdeaOutputString='Employment (thousands)';
    IdeaGrowthString='Employment Growth (percent)';
elseif strcmp(OutputMeasure,'RLP');
    IdeaOutput=SalesReal./Emp*10^3;
    IdeaOutputString='Revenue Labor Productivity (thousands of dollars)';
    IdeaGrowthString='Revenue Labor Productivity Growth (percent)';
end;

% Replace any zero or negative values of IdeaOutput with NaNs
% to avoid imaginary growth rates, etc.
IdeaOutput(IdeaOutput<=0)=NaN;
IdeaGrowth=diff(log(IdeaOutput));
if DHSGrowthRates; % (yt-yt-1)/(0.5*yt +0.5*yt-1)
    yt=trimr(IdeaOutput,1,0);
    ylag=trimr(IdeaOutput,0,1);
    IdeaGrowth=(yt-ylag)./(.5*yt+.5*ylag);
end;

% -----------------------------------------------------------------
% Key company codes of interest
% -----------------------------------------------------------------

companystring=strmat('INTC GOOGL AAPL MSFT PHG1 GENZ MRK NVS BAYRY JNJ PFE HON CSCO SIEGY GE HMC F BA LMT DD DOW AMSWA MTRN');
companycodes=cellstr(companystring);
SelectCompanies=[];
for i=1:length(companycodes);
    eval([companycodes{i} '=find(strcmp(TIC,''' companycodes{i} '''));']);
    SelectCompanies=[SelectCompanies; eval(companystring(i,:))];
end;

% -----------------------------------------------------------------
% Dot-com correction for Market Cap (or other output measure)
% -----------------------------------------------------------------
% For years between 1996 and 2001, if we observe market cap
% in 1995 and 2002: replace with exp(log(market_value_1995)
%  + (year-1995)/7 * (log(market_value_2002)-log(market_value_1995)))
if DotComCorrection;
    yr0=1979;
    dotcomyrs=(1995:2002)';
    growthIdeaOutput1995to2002=log(IdeaOutput(2002-yr0,:)./IdeaOutput(1995-yr0,:));
    dotcomobs=~isnan(growthIdeaOutput1995to2002);
    IdeaOutputDotC=IdeaOutput;
    for i=1:NN;
        if dotcomobs(i);
            IdeaOutputDotC(dotcomyrs-yr0,i)=exp(log(IdeaOutput(1995-yr0,i))+(dotcomyrs-1995)/7*growthIdeaOutput1995to2002(i));
        end;
    end;
    IdeaGrowth=diff(log(IdeaOutputDotC));  % 1981-2015
    if DHSGrowthRates; % (yt-yt-1)/(0.5*yt +0.5*yt-1)
        yt=trimr(IdeaOutputDotC,1,0);
        ylag=trimr(IdeaOutputDotC,0,1);
        IdeaGrowth=(yt-ylag)./(.5*yt+.5*ylag);
    end;
end;

% ---------------------------------------------------
% Basic graphs of Idea Output and Effective Scientists
% ---------------------------------------------------

for i=1:length(SelectCompanies);
    sfigure(1); figsetup; hold on;
    [ax,h1,h2]=plotyy(years,IdeaOutput(:,SelectCompanies(i))/1000,years,EffectiveScientists(:,SelectCompanies(i))/1000);
    darkfactor=.8;
    set(h1,'LineWidth',LW,'Color',myblue);
    set(h2,'LineWidth',LW,'Color',mygreen);
    set(ax(1),'ycolor',myblue*darkfactor);
    set(ax(2),'ycolor',mygreen*darkfactor);
    chadfig2(' ',IdeaOutputString,1,0);
    chadfigyy(ax(2),'Scientists (thousands)');
    if DotComCorrection;
        plot(ax(1),dotcomyrs,IdeaOutputDotC(dotcomyrs-yr0,SelectCompanies(i))/1000,'--','Color',mypurp); 
    end;
    title(Name(SelectCompanies(i)),'FontName','Helvetica','FontSize',11);
    print('-dpsc','-append',fnamegraphs);
end;



% -----------------------------------------------------------
% SAMPLE SELECTION:
% Idea / Market cap growth -- require 3 observations per decade at least
%   and at least 2 consecutive decades
% -----------------------------------------------------------


% 1980s 1990s 2000s 2010s = 4 decades
NumDecades=4;
KeepingObs=zeros(NN,NumDecades)*NaN;         % NumFirms x 4 Decades
NumIdeaGrowth=zeros(NN,NumDecades)*NaN;    % NumFirms x 4 Decades
MedianScientists=zeros(NN,NumDecades)*NaN;   % NumFirms x 4 Decades
MeanIdeaGrowth=zeros(NN,NumDecades)*NaN; % NumFirms x 4 Decades

DecadeYears=[yr1980s yr1990s yr2000s yr2010s];
DecadeG    =[yr1980g yr1990g yr2000g yr2010g];
for t=1:NumDecades;
    NumIdeaGrowth(:,t)=sum(~isnan(IdeaGrowth(DecadeG(:,t),:)))';
    MedianScientists(:,t)=median(EffectiveScientists(DecadeYears(:,t),:),"omitmissing")';
    if strcmp(IdeaGrowthApproach,'Median');
        MeanIdeaGrowth(:,t)=median(IdeaGrowth(DecadeG(:,t),:), "omitmissing")';
    else; % Default is to use the mean (since ideas get capitalized all at once)
        MeanIdeaGrowth(:,t)=mean(IdeaGrowth(DecadeG(:,t),:), "omitmissing")';
    end;
end;

% If MedianScientists<=0, replace with NaN
indx=find(MedianScientists<0);
fprintf('Replacing %4.0f decade observations with zero/negative MedianScientists with NaN\n',sum(indx));
disp '(Recall our earlier condition was just that SOME YEAR had positive RND)';
MedianScientists(MedianScientists<=0)=NaN;

% Adjusting for Lambda
MedianScientists=MedianScientists.^Lambda;


disp ' ';
disp 'Median Effective Scientists, by decade (after lambda adjustment)';
DecadeNames='1980s 1990s 2000s 2010s';
Decades=[1980 1990 2000 2010];
cshow(Name(SelectCompanies),MedianScientists(SelectCompanies,:),'%12.0f',DecadeNames)


% IncreasingScientists: Do we require EffectiveScientists to increase between decades?
disp ' ';
if RequireIncreasingScientists;
    IncreasingScientists=(diff(MedianScientists')>0)';
    IncreasingScientists=[ones(NN,1)*NaN IncreasingScientists];
    disp 'Requiring Increasing Median Effective Scientists, by decade';
else;
    IncreasingScientists=ones(size(MedianScientists));
    disp 'Ignoring IncreasingScientists by setting equal to 1 always';
end;
cshow(Name(SelectCompanies),IncreasingScientists(SelectCompanies,:),'%12.0f',DecadeNames)


disp ' ';
disp 'Number of Idea Growth observations, by decade';
cshow(Name(SelectCompanies),NumIdeaGrowth(SelectCompanies,:),'%12.0f',DecadeNames)
cshow(Name(500:600),NumIdeaGrowth(500:600,:),'%12.0f',DecadeNames)

disp ' ';
disp 'Mean (or median) Idea Growth (all observations), by decade';
cshow(Name(SelectCompanies),MeanIdeaGrowth(SelectCompanies,:),'%12.3f',DecadeNames)

% Require at least 3 observations per decade
DropIdeaGrowth=(NumIdeaGrowth<3);
MeanIdeaGrowth(DropIdeaGrowth)=NaN;

disp ' ';
disp 'Mean (or median) Idea Growth (at least 3 observations), by decade';
numremaining=sum(any(~isnan(MeanIdeaGrowth')));
fprintf('  The number of firms remaining now is %8.0f\n',numremaining);
cshow(Name(SelectCompanies),MeanIdeaGrowth(SelectCompanies,:),'%12.3f',DecadeNames)
cshow(Name(500:550),MeanIdeaGrowth(500:550,:),'%12.3f',DecadeNames)
MeanIdeaGrowthRaw=MeanIdeaGrowth; % Save this version before dropping negatives

% -----------------------------------------------------------
% BENCHMARK Case: 
%       This is the baseline sampling frame:
%        - 2 consecutive decades of postive MeanIdeaGrowth
% -----------------------------------------------------------

disp ' '; disp ' ';
disp '-----------------------';
disp ' Idea TFP Calculations';
disp '-----------------------';

if ~isnan(MinimumGrowthRate); % Replace growth rates below this value (e.g. 0.01) with this value
    disp ' ';
    TotObs=sum(~isnan(vector(MeanIdeaGrowth)));
    LessThanMin=sum(vector(MeanIdeaGrowthRaw)<MinimumGrowthRate);    
    PercentWindsorized=LessThanMin/TotObs*100;
    fprintf('  >>>> Updating growth rates so lowest value is %8.4f\n',MinimumGrowthRate);
    fprintf('  >>>> This affects %6.2f percent of the observations.\n',PercentWindsorized);
    MeanIdeaGrowth(MeanIdeaGrowth<MinimumGrowthRate)=MinimumGrowthRate;    
    if WindsorizeTop;
        TopGrowthCutoff=prctile(vector(MeanIdeaGrowth),100-PercentWindsorized);
        fprintf('  >>>> Windsorizing: Updating growth rates so HIGHEST value is %8.4f\n',TopGrowthCutoff);
        MeanIdeaGrowth(MeanIdeaGrowth>TopGrowthCutoff)=TopGrowthCutoff;
    end;
    disp '       MeanIdeaGrowth BEFORE       MeanIdeaGrowth AFTER';
    cshow(' ',[MeanIdeaGrowthRaw(1:50,:) MeanIdeaGrowth(1:50,:)],'%8.3f','d1 d2 d3 d4 d1 d2 d3 d4');
end;

if RequireAllDecadesPosGrowth==0; % Benchmark case: only keep decades with positive growth
    % Drop specific decades with negative MeanIdeaGrowth (always)
    MeanIdeaGrowth(MeanIdeaGrowth<=0)=NaN;    
elseif RequireAllDecadesPosGrowth==-1; % Robust 3: Consider *all* decades, even if negative growth
    disp 'Robust3: Keeping all decades, even if negative growth';
elseif RequireAllDecadesPosGrowth==1; % Robust2: Drop if *any* decade has negative MeanIdeaGrowth
    FirmHasDecadeNegativeIdeaGrowth=any(MeanIdeaGrowth'<0);
    MeanIdeaGrowth(FirmHasDecadeNegativeIdeaGrowth,:)=NaN;
    disp ' ';
    disp 'Robust2: Dropping if *any* decade has negative MeanIdeaGrowth';
    disp '       MeanIdeaGrowth BEFORE       MeanIdeaGrowth AFTER';
    cshow(' ',[MeanIdeaGrowthRaw(1:50,:) MeanIdeaGrowth(1:50,:)],'%8.3f','d1 d2 d3 d4 d1 d2 d3 d4');
end;


% Now loop through companies to construct IdeaTFP 2/3/4 decades
KeepDecade=~isnan(MeanIdeaGrowth);
KeepIdeaTFP=zeros(NN,1);
IdeaTFP=zeros(NN,NumDecades)*NaN;
RandShow=rand(NN,1); % Show values for 1 percent sample as well.
PercentSample=.004;
for i=1:NN;
%for i=1:3000;
    % Reduce to these six cases and search for 1st 1:
    % 1100, 0110, 0011, 1110, 0111, 1111
    % Recode 1011, 1101 ==> 0011 and 1100
    if KeepDecade(i,:)==[1 0 1 1]; KeepDecade(i,:)=[0 0 1 1]; MeanIdeaGrowth(i,1)=NaN; end;
    if KeepDecade(i,:)==[1 1 0 1]; KeepDecade(i,:)=[1 1 0 0]; MeanIdeaGrowth(i,4)=NaN;end;
    if sum(KeepDecade(i,:)')>1; % So we at least have a chance!
    
        ideatfp=MeanIdeaGrowth(i,:)./MedianScientists(i,:);
        if any(find(SelectCompanies==i)) | RandShow(i)<PercentSample;
            disp ' ';
            disp(Name{i});
            cshow('EffSci:',MedianScientists(i,:),'%8.0f',[],[],1);
            cshow('MCGrow:',MeanIdeaGrowth(i,:),'%8.3f',[],[],1);
            cshow('IncSci:',IncreasingScientists(i,:),'%8.0f',[],[],1);
            cshow('Before:',ideatfp*100,'%8.3f',[],[],1);
        end;
        
        % Now step through and find the first one with increasing scientists
        foundfirst=0;
        for t=1:(NumDecades-1);
            if ~isnan(ideatfp(t)) | foundfirst>0;
                if IncreasingScientists(i,t+1);
                    if foundfirst==0;
                        % Then this is our first!
                        foundfirst=t;
                        if DHSGrowthRates; % 
                            ideatfp=DHSCorrection(ideatfp,t);
                        else;
                            ideatfp=ideatfp/ideatfp(t);
                        end;
                    else; % Already have found the first one with increasing sci
                          % Nothing to do...
                    end;
                else; % Then IncreasingScientists(i,t+1)==0
                    if foundfirst==0;
                        ideatfp(t)=NaN;
                    else;
                        ideatfp(t+1)=NaN;
                    end;
                end;
            end;
        end; % t to find first.
        if sum(ideatfp', "omitmissing")==1; ideatfp=[NaN NaN NaN NaN]; end; % Only 1 decade
        ideatfp(isinf(ideatfp))=NaN;
        keepdecade=~isnan(ideatfp);
        if keepdecade==[1 0 1 1]; ideatfp(1)=NaN; end;
        if keepdecade==[1 0 0 1]; ideatfp([1 4])=NaN; end;
        if keepdecade==[1 1 0 1]; ideatfp(4)=NaN; end;
        IdeaTFP(i,:)=ideatfp;
        if any(find(SelectCompanies==i)) | RandShow(i)<PercentSample;
            cshow('After :',ideatfp,'%8.3f',[],[],1);
        end;

    end;
end;

% ----------------------------
% Now plot Select Companies
% ----------------------------
fig=sfigure(2); figsetup;
set(fig,'PaperUnits','normalized');
set(fig,'PaperPosition', [0 0 1 1]);
for i=1:length(SelectCompanies);
    clf;
    subplot('Position',[.2 .55 .6 .35]);
    [ax,h1,h2]=plotyy(Decades,MeanIdeaGrowth(SelectCompanies(i),:),Decades,MedianScientists(SelectCompanies(i),:)/1000);
    darkfactor=.8;
    set(h1,'LineWidth',LW,'Color',myblue);
    set(h2,'LineWidth',LW,'Color',mygreen);
    set(ax(1),'ycolor',myblue*darkfactor);
    set(ax(2),'ycolor',mygreen*darkfactor);
    relabelaxis([1980 1990 2000 2010],strmat('1980s 1990s 2000s 2010s'),'x');
    lab=strmat('1980s 1990s 2000s 2010s');
    num=[1980 1990 2000 2010];
    relabelaxis(num,lab,'x',ax(1));
    relabelaxis(num,lab,'x',ax(2));
    chadfig2(' ',IdeaGrowthString,1,0);
    chadfigyy(ax(2),'Scientists (thousands)');

    subplot('Position',[.2 .1 .6 .35]);
    hold on;
    plot(Decades,IdeaTFP(SelectCompanies(i),:),'-','LineWidth',LW,'Color',myblue);
    plot(Decades,IdeaTFP(SelectCompanies(i),:),'o','Color',mygreen);
    relabelaxis([1980 1990 2000 2010],strmat('1980s 1990s 2000s 2010s'),'x');
    chadfig2('Decade','Idea TFP',1,0);
    title(Name{SelectCompanies(i)},'FontName','Helvetica','FontSize',11);

    print('-dpsc','-append',fnamegraphs);
end;


% -------------------------------------------------------------
% Construct 2, 3, 4 decade summary statistics for all companies
% -------------------------------------------------------------

NumDecades=sum(~isnan(IdeaTFP'))';
DeadObs=isnan(IdeaTFP);  % These observations are dead ==> turn off Scientists as well.
MedianScientistsRaw=MedianScientists; % Saving original...
MedianScientists(DeadObs)=NaN;
MeanIdeaGrowthRaw=MeanIdeaGrowth;
MeanIdeaGrowth(DeadObs)=NaN;

SimpleDecades=(1:4)';
disp ' ';
Prctiles=[0 25 50 75 100]';
p25=2; p50=3; p75=4;
imean_log2=zeros(4,3)*NaN;  % Decades x 2/3/4
smean_log2=zeros(4,3)*NaN;  % Decades x 2/3/4
gmean     =zeros(4,3)*NaN;  % Decades x 2/3/4
iprc=zeros(length(Prctiles),4,3)*NaN;  % 25/50/75 x Decades x 2/3/4
sprc=zeros(length(Prctiles),4,3)*NaN;  % 25/50/75 x Decades x 2/3/4
disp ' '; disp ' ';
disp 'Note: "Mean" below is 2^(Mean(log2(.)))';

for n=2:4;
    smpl=(NumDecades==n);
    Nsmpl=sum(smpl);
    disp ' ';
    disp '-----------------------------------------------------------------';
    disp ' '
    fprintf('The number of firms with %1.0f decades is %6.0f\n',[n Nsmpl]);
    ideatfp=IdeaTFP(smpl,:);
    scientists=MedianScientists(smpl,:);
    ideagrowth=MeanIdeaGrowth(smpl,:);
    y=zeros(Nsmpl,n); sci=y; g=y;
    for i=1:Nsmpl; % Get the n obs
        indx=find(~isnan(ideatfp(i,:)));
        y(i,:)=ideatfp(i,indx);
        sci(i,:)=scientists(i,indx);
        g(i,:)=ideagrowth(i,indx);
    end;
    if WeightingByScientists;
        PrcWeights=median(sci', "omitmissing")'; % Median of Scientists across decades
        PrcWeights=PrcWeights.^(1/Lambda); % Undo the lambda for the weights
        PrcWeights=PrcWeights/sum(PrcWeights); % Sum to one
    else;
        PrcWeights=ones(Nsmpl,1);
    end;
    sci1=div(sci,sci(:,1)); % Normalize so first value is 1
    imean_log2(1:n,n) =weightedmean(log2(y),PrcWeights)';
    smean_log2(1:n,n) =weightedmean(log2(sci1),PrcWeights)';
    gmean(1:n,n)      =weightedmean(g,PrcWeights)';
    
    iprc(:,1:n,n)=wprctile(y,Prctiles,PrcWeights);
    fmt ='%6.0f %10.4f %10.4f %10.4f %10.4f %12.4f %9.0f';
    fmt1='%10.4f %10.4f %10.4f %10.4f %12.4f %9.0f';
    fprintf('Idea TFP: Percentiles for %1.0f decades (+avg growth rate // half life)\n',n);
    giTFP=compugrowthrate(2.^(imean_log2(:,n)'));
    cshow('* Mean',[2.^(imean_log2(:,n)') giTFP],fmt1);
    cshow('1/Mean',1./(2.^(imean_log2(:,n)')),fmt1);
    cshow(' ',[Prctiles squeeze(iprc(:,:,n)) compugrowthrate(squeeze(iprc(:,:,n)))],fmt);
    
    sprc(:,1:n,n)=wprctile(sci1,Prctiles,PrcWeights);
    disp ' ';
    fmt ='%6.0f %10.3f %10.3f %10.3f %10.3f %12.4f %9.0f';
    fmt1='%10.3f %10.3f %10.3f %10.3f %12.4f %9.0f';
    fprintf('Effective Scientists: Percentiles for %1.0f decades (+avg growth rate // Yrs2Double)\n',n);
    cshow('* Mean',[2.^(smean_log2(:,n)') compugrowthrate(2.^(smean_log2(:,n)'))],fmt1);
    cshow(' ',[Prctiles squeeze(sprc(:,:,n)) compugrowthrate(squeeze(sprc(:,:,n)))],fmt);

    % beta calculation
    disp ' ';
    meanideagrowth=mean(gmean(1:n,n));
    cshow('IdeaGrowth',[gmean(:,n)' meanideagrowth],fmt1);
    fprintf('      Implied beta = %8.2f\n',-giTFP(1)/meanideagrowth);

    
    sfigure(1); figsetup; 
    axnum=(-8:0)';
    axlab=strmat('1/256#1/128# 1/64 # 1/32 # 1/16 #  1/8 #  1/4 #  1/2 #   1','#');
    plot((1:n),log2(squeeze(iprc(p25,1:n,n))),'--','Color',mygreen);
    plot((1:n),log2(squeeze(iprc(p75,1:n,n))),'--','Color',mygreen);
    plot((1:n),log2(squeeze(iprc(p50,1:n,n))),'Color',myblue,'LineWidth',LW);
    relabelaxis((1:4),strmat('Decade1 Decade2 Decade3 Decade4'),'x');
    imin=floor(log2(min(squeeze(iprc(1,1:n,n)))));  % e.g. -4 ==> 1/16
    %indx=find(axnum==imin);
    indx=find(axnum==-7);
    relabelaxis(log2(2.^axnum(indx:end)),axlab(indx:end,:),'y');
    chadfig2('Decade','Idea TFP',1,0);
    if Lambda==1;
        print('-depsc',['CompustatIdeaTFP' num2str(n) '_' CaseName]);
    end;
    print('-dpsc','-append',fnamegraphs);

    % Histograms
    %axlab=strmat('1/4096#1/1048# 1/256 # 1/64 # 1/16 #  1/4 #  1 #  4 #  16 # 64 # 256# 1048#4096','#');
    axlab=strmat('1/10^6#1/100,000#1/10,000# 1/1,000#  1/100 #  1/10  #   1  #  10  # 100 # 1,000#10,000','#');
    axnum=(-6:4)';
    sfigure(1); figsetup;
    htfp=histogram(log10(y(:,n)));
    hsci=histogram(log10(sci1(:,n)));
    xmin=floor(min(log10(y(:,n))));
    xmax=ceil(max(log10(sci1(:,n))));
    x1=find(axnum==xmin);
    x2=find(axnum==xmax);
    relabelaxis(axnum(x1:x2),axlab(x1:x2,:),'x');
    chadfig2('Factor change in Idea TFP and # of Researchers','Number of firms',1,0);
    xtick=get(gca,'XTick');
    ytick=get(gca,'YTick');
    text(xtick(2),.8*ytick(end-1),mlstring('Research\\ productivity'),'Color',myblue*.8);
    text(xtick(end-1),.8*ytick(end-1),mlstring('Number of\\ Researchers'),'Color',myorng*.7);
    title(sprintf('Across %1.0f decades',n),'FontName','Helvetica','FontSize',11);
    if Lambda==1;
        print('-depsc',['CompustatHist' num2str(n) '_' CaseName]);
    end;
    print('-dpsc','-append',fnamegraphs);
    
    disp ' '; disp ' ';
    disp 'Key Statistics';
    disp 'Percent of firms with idea TFP factor >= 1';
    frac1=sum(y(:,n)>=1)/Nsmpl*100;
    fprintf('   Across %1.0f decades: %8.3f percent\n',[n frac1]);    
    disp ' ';
    disp 'Percent of firms with idea TFP neither rising nor falling by more than 1% per year on average';
    keylevel=exp(.01*10*(n-1));
    frac2=sum( (y(:,n)<keylevel) & (y(:,n)>1/keylevel) )/Nsmpl*100;
    fprintf('   Across %1.0f decades: %8.3f percent\n',[n frac2]);    
end;



% Now plot IdeaTFP and Scientists -- main graph
% Means of log2(ideatfp) and log2(sci)
sfigure(1); figsetup;
[ax,h1,h2]=plotyy(Decades,imean_log2,Decades,smean_log2);
darkfactor=.8;
set(h1,'LineWidth',LW,'Color',myblue);
set(h2,'LineWidth',LW,'Color',mygreen);
set(ax(1),'ycolor',myblue*darkfactor);
set(ax(2),'ycolor',mygreen*darkfactor);
%lab=strmat('1980s 1990s 2000s 2010s');
%lab=strmat('Start#1 decade#2 decades#3 decades','#');
lab=strmat('1st decade#2nd decade#3rd decade#4th decade','#');
num=[1980 1990 2000 2010];
relabelaxis(num,lab,'x',ax(1));
relabelaxis(num,lab,'x',ax(2));
%chadfig2(' ','Idea TFP',1,0);
%chadfigyy(ax(2),'Effective Scientists');

axnum=(-8:0)';
axlab=strmat('1/256#1/128# 1/64 # 1/32 # 1/16 #  1/8 #  1/4 #  1/2 #   1','#');
imin=floor(min(imean_log2(:,4)));  % e.g. -4 ==> 1/16
indx=find(axnum==imin);
relabelaxis(axnum(indx:end),axlab(indx:end,:),'y',ax(1));

axnum=(0:5)';
axlab=strmat(' 1 # 2 # 4 # 8 # 16# 32','#');
smax=ceil(max(smean_log2(:,4)));  % e.g. 4 ==> 16
indx=find(axnum==smax);
relabelaxis(axnum(1:indx),axlab(1:indx,:),'y',ax(2));
fs=14;
str=mlstring('Idea TFP\\   (left scale)');
text(1985,log(1/1.5),str,'FontSize',fs);
str=mlstring('Effective number of\\ researchers (right scale)');
text(1998,log(1/1.7),str,'FontSize',fs);
chadfig2(' ','Index (Initial=1)',1,0);
chadfigyy(ax(2),'Index (Initial=1)');
makefigwide
if Lambda==1;
    print('-depsc',['CompustatIdeaTFPMain_' CaseName]);
end;
print('-dpsc','-append',fnamegraphs);

diary off;

function itfp=DHSCorrection(ideatfp,t);
   % Given ideatfp=[NaN .05 .001 .01] and t=2
   %   1. Compute DHS growth rates relative to period t
   %   2. Construct levels relative to period t
   y=ideatfp(t:end)';
   dhs=zeros(size(y))*NaN;
   for i=2:length(y);
       dhs(i)=(y(i)-y(1))./(.5*y(i)+.5*y(1));
   end;
   fact=exp(dhs);
   %fact=(1+dhs).*(dhs>=0)+1./(1-dhs).*(dhs<0);
   itfp=fact'; itfp(1)=1;
   if t>1;
       itfp=[NaN*ones(1,t-1) itfp];
   end;
   %keyboard
end
