% ReadPatentData
%
%   Read Michael's .csv file extracts from PATSTAT
%    Based on "US_*.csv" data ==> at least 1 patent filed in USPTO

clear;
diarychad('ReadPatentData')

%[countrycode,country,currency_unit,year,rgdpe,rgdpo,pop,emp,avh,hc,ccon,cda,cgdpe,cgdpo,ck,ctfp,cwtfp,rgdpna,rconna,rdana,rkna,rtfpna,rwtfpna,labsh,delta,xr,pl_con,pl_da,pl_gdpo,i_cig,i_xm,i_xr,i_outlier,cor_exp,statcap,csh_c,csh_i,csh_g,csh_x,csh_m,csh_r,pl_c,pl_i,pl_g,pl_x,pl_m,pl_k]...
%    =textread('pwt90.csv',fmt,'delimiter',',','headerlines',1,'emptyvalue',NaN);


fmts='%s '; fmtf='%f '; 
zz=ones(116,1)*fmtf;  fmt2=vector(char(zz)')';  % 1900-2015
fmt=['%f %q ' fmt2]; fmt(end)=[]; % delete last space


csvname={'US_semiconductor',
         'US_non-semiconductor'
         }
varname={'us_semi',
         'us_non'
         }

for i=1:length(csvname);
    
    [id,applicant_name,y1900,y1901,y1902,y1903,y1904,y1905,y1906,y1907,y1908,y1909,y1910,y1911,y1912,y1913,y1914,y1915,y1916,y1917,y1918,y1919,y1920,y1921,y1922,y1923,y1924,y1925,y1926,y1927,y1928,y1929,y1930,y1931,y1932,y1933,y1934,y1935,y1936,y1937,y1938,y1939,y1940,y1941,y1942,y1943,y1944,y1945,y1946,y1947,y1948,y1949,y1950,y1951,y1952,y1953,y1954,y1955,y1956,y1957,y1958,y1959,y1960,y1961,y1962,y1963,y1964,y1965,y1966,y1967,y1968,y1969,y1970,y1971,y1972,y1973,y1974,y1975,y1976,y1977,y1978,y1979,y1980,y1981,y1982,y1983,y1984,y1985,y1986,y1987,y1988,y1989,y1990,y1991,y1992,y1993,y1994,y1995,y1996,y1997,y1998,y1999,y2000,y2001,y2002,y2003,y2004,y2005,y2006,y2007,y2008,y2009,y2010,y2011,y2012,y2013,y2014,y2015]...
      =textread([csvname{i} '.csv'],fmt,'delimiter',',','headerlines',1,'emptyvalue',NaN);
    eval([varname{i} '=[y1900 y1901 y1902 y1903 y1904 y1905 y1906 y1907 y1908 y1909 y1910 y1911 y1912 y1913 y1914 y1915 y1916 y1917 y1918 y1919 y1920 y1921 y1922 y1923 y1924 y1925 y1926 y1927 y1928 y1929 y1930 y1931 y1932 y1933 y1934 y1935 y1936 y1937 y1938 y1939 y1940 y1941 y1942 y1943 y1944 y1945 y1946 y1947 y1948 y1949 y1950 y1951 y1952 y1953 y1954 y1955 y1956 y1957 y1958 y1959 y1960 y1961 y1962 y1963 y1964 y1965 y1966 y1967 y1968 y1969 y1970 y1971 y1972 y1973 y1974 y1975 y1976 y1977 y1978 y1979 y1980 y1981 y1982 y1983 y1984 y1985 y1986 y1987 y1988 y1989 y1990 y1991 y1992 y1993 y1994 y1995 y1996 y1997 y1998 y1999 y2000 y2001 y2002 y2003 y2004 y2005 y2006 y2007 y2008 y2009 y2010 y2011 y2012 y2013 y2014 y2015];']);
end;
clear y1900 y1901 y1902 y1903 y1904 y1905 y1906 y1907 y1908 y1909 y1910 y1911 y1912 y1913 y1914 y1915 y1916 y1917 y1918 y1919 y1920 y1921 y1922 y1923 y1924 y1925 y1926 y1927 y1928 y1929 y1930 y1931 y1932 y1933 y1934 y1935 y1936 y1937 y1938 y1939 y1940 y1941 y1942 y1943 y1944 y1945 y1946 y1947 y1948 y1949 y1950 y1951 y1952 y1953 y1954 y1955 y1956 y1957 y1958 y1959 y1960 y1961 y1962 y1963 y1964 y1965 y1966 y1967 y1968 y1969 y1970 y1971 y1972 y1973 y1974 y1975 y1976 y1977 y1978 y1979 y1980 y1981 y1982 y1983 y1984 y1985 y1986 y1987 y1988 y1989 y1990 y1991 y1992 y1993 y1994 y1995 y1996 y1997 y1998 y1999 y2000 y2001 y2002 y2003 y2004 y2005 y2006 y2007 y2008 y2009 y2010 y2011 y2012 y2013 y2014 y2015
% indx=find(strncmp(applicant_name,'IBM',3))


yr0=1899;
yrs=(1960:2013)'; % Years we care about
yy=yrs-yr0;

TotalSemi=sum(us_semi);
us_both=us_semi+us_non;

% Percent of firms US that are due to semiconductors
us_pct_own = 100*us_semi./us_both; 

% Percent of years total semiconductor US summed over all firms due to firm i
us_pct_all = 100*div(us_semi,TotalSemi);  


% Collect all firms that have some year in yrs with US_pct_all > CitationCutoff
CitationCutoff = .02*100
MeetsCutoff_it = us_pct_all >= CitationCutoff;
MeetsCutoff = find(any(MeetsCutoff_it'==1)');
%[blah indx]=sort(us_pct_all(MeetsCutoff,1980-yr0),'descend');
[blah indx]=sort(max(us_pct_all(MeetsCutoff,yrs-yr0)')','descend');

KeyYears=[1970 1975 1980 1990 2000 2010];
tle='ID 1970 1975 1980 1990 2000 2010';
disp 'us_pct_all for firms with more than CitationCutoff percent in any year'
disp 'Sorted by Max share per company since 1960';
cshow(applicant_name(MeetsCutoff(indx)),[id(MeetsCutoff(indx)) us_pct_all(MeetsCutoff(indx),KeyYears-yr0)],'%12.0f %10.2f',tle)

disp ' ';
NN=length(MeetsCutoff);
fprintf('   Number of firms = %4.0f\n',NN);


% Companies to consolidate because they are the same firm
ToMergeData=[
%Companies to Keep and Merge			
%          ID	Merge	Unique	Order	Name
11525756	0	1	16	% IBM (INTERNATIONAL BUSINESS MACHINES CORPORATION)
1978151 	1	0	0	% BELL LABORATORIES
29394026	0	1	0	% WESTINGHOUSE ELECTRIC CORPORATION
27150877	0	1	20	% TEXAS INSTRUMENTS
25253329	2	1	25	% SIEMENS
10810749	0	1	21	% HITACHI
8391757 	0	1	15	% GE (GENERAL ELECTRIC COMPANY)
27676560	0	1	22	% TOSHIBA CORPORATION
22460284	0	1	19	% RCA CORPORATION (RADIO CORPORATION OF AMERICA)
19553540	0	1	26	% NEC CORPORATION
26695767	0	1	0	% TAIWAN SEMICONDUCTOR MANUFACTURING COMPANY
29390663	0	1	0	% WESTERN ELECTRIC COMPANY
7991580 	0	1	0	% FUJITSU
20026391	3	0	0	% NORTH AMERICAN PHILIPS COMPANY
23790964	4	1	24	% SAMSUNG ELECTRONICS COMPANY
25254688	2	0	0	% SIEMENS-SCHUCKERTWERKE
21485576	3	1	18	% PHILIPS ELECTRONICS
28023804	3	0	0	% U.S. PHILIPS CORPORATION
18631123	0	1	0	% MITSUBISHI ELECTRIC CORPORATION
19014776	0	1	17	% MOTOROLA
23790837	4	0	0	% SAMSUNG DISPLAY
21485567	3	0	0	% PHILIPS ELECTRONIC ASSOCIATED INDUSTRIES
21485543	3	0	0	% PHILIPS ELECTRONIC AND ASSOCIATED INDUSTRIES
25253345	2	0	0	% SIEMENS & HALSKE
21485499	3	0	0	% PHILIPS ELECTRICAL INDUSTRIES
1276779 	1	1	14	% AT&T (AMERICAN TELEPHONE AND TELEGRAPH COMPANY)
23791125	4	0	24	% SAMSUNG MOBILE DISPLAY COMPANY
7111586 	5	1	13	% FAIRCHILD CAMERA & INSTRUMENT CORPORATION
11800943	0	1	1	% INTEL CORPORATION
7111598 	5	0	0	% FAIRCHILD CAMERA AND INSTRUMENT CORPORATION
698545  	0	1	2	% AMD (ADVANCED MICRO DEVICES)
11809783	0	1	6	% INTERNATIONAL RECTIFIER CORPORATION
1025377 	0	1	0	% APPLIED MATERIALS
24766218	0	1	0	% SHARP CORPORATION
26575407	0	1	0	% SYLVANIA ELECTRIC PRODUCTS
10980719	0	1	23	% HONEYWELL INTERNATIONAL
22135011	0	1	10	% QUALCOMM
2916894 	0	1	11	% BROADCOM CORPORATION
19510399	0	1	3	% NATIONAL SEMICONDUCTOR CORPORATION
7809483 	0	1	4	% FREESCALE SEMICONDUCTOR
746431  	0	1	5	% ANALOG DEVICES
20102959	0	1	12	% NVIDIA CORPORATION
25402522	0	1	29	% SK HYNIX
18397778	0	1	27	% MICRON TECHNOLOGY
18082643	0	1	30	% MEDIATEK
20103297	0	1	28	% NXP SEMICONDUCTORS
  ];

ToMergeID=ToMergeData(:,1);
ToMerge=ToMergeData(:,2);
ToKeep =ToMergeData(:,3);
ToOrder =ToMergeData(:,4);

US_pct_own=[]; % Capital letter handles the merge
US_pct_all=[];
US_id=[];
US_name=[];

for i=1:max(ToMerge);
    isame=find(ToMerge==i);
    i_orig=[]; % Store the original indexes of companies to merge
    for j=1:length(isame);
        indx=find(id==ToMergeID(isame(j)));
        i_orig=[i_orig; indx];
    end;
    applicant_name(i_orig)
    for j=1:length(i_orig); % Replace all orig with the sum across the same companies
        us_pct_own(i_orig(j),:)=100*sum(us_semi(i_orig,:))./sum(us_both(i_orig,:));
        us_pct_all(i_orig(j),:)=100*div(sum(us_semi(i_orig,:)),TotalSemi);
    end;
end;

for i=1:length(ToMerge); % Delete the duplicates (NaN)
    if ToKeep(i)==1;
        i_orig=find(id==ToMergeID(i));
        US_pct_own=[US_pct_own; us_pct_own(i_orig,:)];
        US_pct_all=[US_pct_all; us_pct_all(i_orig,:)];
        US_id=[US_id; id(i_orig)];
        US_name=[US_name; applicant_name(i_orig)];
    end;
end;

disp ' '; disp ' ';
disp '------------------------------';
disp 'After Merging subsidiaries...'
disp '------------------------------';
disp 'US_pct_all for firms with more than CitationCutoff percent in any year';
cshow(US_name,[US_id US_pct_all(:,KeyYears-yr0)],'%12.0f %10.2f',tle)

disp ' '; disp ' ';
disp 'US_pct_own for firms with more than CitationCutoff percent in any year';
cshow(US_name,[US_id US_pct_own(:,KeyYears-yr0)],'%12.0f %10.2f',tle)

NN=length(US_name);
fprintf('   Number of firms = %4.0f\n',NN);

%abc

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot and smooth semiconductor share of own patents
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
definecolors
HPParam=100
cites_smoothed=zeros(length(yrs),NN)*NaN;
cites_own = US_pct_own(:,yrs-yr0)';
cites_own(isnan(cites_own))=0; % Replace NaNs with zero to help hpfilter
Name=US_name;
delete('ReadPatentData.ps');
warning off
for i=1:NN;
    sfigure(1); clf; hold on;
    cites_smoothed(:,i)=hpfilter(cites_own(:,i),HPParam);
    cites_smoothed(cites_smoothed<0)=0; % Replace negatives with 0 in smoothed
    plot(yrs,cites_own(:,i),'-','Color',myblue);
    plot(yrs,cites_smoothed(:,i),'-','Color',myred);
    chadfig2(' ','Semi share of own patents',1,0);
    title(Name(i),'FontName','Helvetica','FontSize',11);
    print('-dpsc','-append','ReadPatentData');
    %wait
end;
warning on


%shortnames='Year Hitachi Fuji Toshiba IBM NEC Mitsu Siemens AT&T RCA TI Philips GE Western Motorola Hughes WestingH Licentia Eaton Honey SELC GM IntlStd Fairchild Standard Ericsson Battelle BOE ITT Micron Glue Philco Purdu Samsung Sylvania TSMC';
shortnames='Year IBM WestingH TI Siemens Hitachi GE Toshiba RCA NEC TSMC Western Fuji Samsung Philips Mitsu Motorola ATT Fairchild Intel AMD IntlRec AppliedM Sharp Sylvania Honey Qualcom Broadcom NatlSemi Free Analog Nvidia SKHynix Micron MediaTek NXP'; % Ripley Semtech Unitrode';

disp ' '; disp ' ';
disp 'Smoothed Semiconductor share of own patents -- for merging R&D';
cshow(' ',[yrs cites_smoothed],'%6.0f %10.2f',shortnames)

Nkeep=max(ToOrder);
T=length(yrs);
cites_smoothed_ordered=zeros(T,Nkeep)*NaN;
NewOrder=ToOrder(ToKeep==1);
for i=1:NN;
    if NewOrder(i)~=0;
        cites_smoothed_ordered(:,NewOrder(i))=cites_smoothed(:,i);
    end;
end;
NewNames=cellstr(strmat(shortnames));
NewNames(1)=[]; % Drop 'Year' for now
Names=NewNames;
Names(NewOrder==0)=[]
NewOrder(NewOrder==0)=[]
[blah,indx]=sort(NewOrder);

Names=Names(indx);
Names=['Year'; Names];
disp ' '; disp ' ';
cites_smoothed_ordered(:,7:9)=[]; % Drop Ripley, Semtech, Unitrode for now
disp 'Smoothed Semiconductor share of own patents -- for merging R&D';
cshow(' ',[yrs cites_smoothed_ordered],'%6.0f %10.2f',Names)


diary off;

% Other company TIC codes for Compustat
% HTHIY FJTSY TOSYY IBM NIPNY MIELY SIEGY T T1 T.2 RCA.1 TXN PHG PHG1 GE PHG PHG1 MSI

