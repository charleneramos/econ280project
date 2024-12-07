% ReadCitationData
%
%   Read Michael's .csv file extracts from PATSTAT
%   This version is based on **citations**

clear all;
diarychad('ReadCitationData')

%[countrycode,country,currency_unit,year,rgdpe,rgdpo,pop,emp,avh,hc,ccon,cda,cgdpe,cgdpo,ck,ctfp,cwtfp,rgdpna,rconna,rdana,rkna,rtfpna,rwtfpna,labsh,delta,xr,pl_con,pl_da,pl_gdpo,i_cig,i_xm,i_xr,i_outlier,cor_exp,statcap,csh_c,csh_i,csh_g,csh_x,csh_m,csh_r,pl_c,pl_i,pl_g,pl_x,pl_m,pl_k]...
%    =textread('pwt90.csv',fmt,'delimiter',',','headerlines',1,'emptyvalue',NaN);


fmts='%s '; fmtf='%f '; 
zz=ones(116,1)*fmtf;  fmt2=vector(char(zz)')';  % 1900-2015
fmt=['%f %q ' fmt2]; fmt(end)=[]; % delete last space


csvname={'citations_semiconductor',
         'citations_non-semiconductor'
         }
varname={'citations_semi',
         'citations_non'
         }

for i=1:length(csvname);
    
    [applicant_id,applicant_name,y1900,y1901,y1902,y1903,y1904,y1905,y1906,y1907,y1908,y1909,y1910,y1911,y1912,y1913,y1914,y1915,y1916,y1917,y1918,y1919,y1920,y1921,y1922,y1923,y1924,y1925,y1926,y1927,y1928,y1929,y1930,y1931,y1932,y1933,y1934,y1935,y1936,y1937,y1938,y1939,y1940,y1941,y1942,y1943,y1944,y1945,y1946,y1947,y1948,y1949,y1950,y1951,y1952,y1953,y1954,y1955,y1956,y1957,y1958,y1959,y1960,y1961,y1962,y1963,y1964,y1965,y1966,y1967,y1968,y1969,y1970,y1971,y1972,y1973,y1974,y1975,y1976,y1977,y1978,y1979,y1980,y1981,y1982,y1983,y1984,y1985,y1986,y1987,y1988,y1989,y1990,y1991,y1992,y1993,y1994,y1995,y1996,y1997,y1998,y1999,y2000,y2001,y2002,y2003,y2004,y2005,y2006,y2007,y2008,y2009,y2010,y2011,y2012,y2013,y2014,y2015]...
      =textread([csvname{i} '.csv'],fmt,'delimiter',',','headerlines',1,'emptyvalue',NaN);
    eval([varname{i} '=[y1900 y1901 y1902 y1903 y1904 y1905 y1906 y1907 y1908 y1909 y1910 y1911 y1912 y1913 y1914 y1915 y1916 y1917 y1918 y1919 y1920 y1921 y1922 y1923 y1924 y1925 y1926 y1927 y1928 y1929 y1930 y1931 y1932 y1933 y1934 y1935 y1936 y1937 y1938 y1939 y1940 y1941 y1942 y1943 y1944 y1945 y1946 y1947 y1948 y1949 y1950 y1951 y1952 y1953 y1954 y1955 y1956 y1957 y1958 y1959 y1960 y1961 y1962 y1963 y1964 y1965 y1966 y1967 y1968 y1969 y1970 y1971 y1972 y1973 y1974 y1975 y1976 y1977 y1978 y1979 y1980 y1981 y1982 y1983 y1984 y1985 y1986 y1987 y1988 y1989 y1990 y1991 y1992 y1993 y1994 y1995 y1996 y1997 y1998 y1999 y2000 y2001 y2002 y2003 y2004 y2005 y2006 y2007 y2008 y2009 y2010 y2011 y2012 y2013 y2014 y2015];']);
end;
clear y1900 y1901 y1902 y1903 y1904 y1905 y1906 y1907 y1908 y1909 y1910 y1911 y1912 y1913 y1914 y1915 y1916 y1917 y1918 y1919 y1920 y1921 y1922 y1923 y1924 y1925 y1926 y1927 y1928 y1929 y1930 y1931 y1932 y1933 y1934 y1935 y1936 y1937 y1938 y1939 y1940 y1941 y1942 y1943 y1944 y1945 y1946 y1947 y1948 y1949 y1950 y1951 y1952 y1953 y1954 y1955 y1956 y1957 y1958 y1959 y1960 y1961 y1962 y1963 y1964 y1965 y1966 y1967 y1968 y1969 y1970 y1971 y1972 y1973 y1974 y1975 y1976 y1977 y1978 y1979 y1980 y1981 y1982 y1983 y1984 y1985 y1986 y1987 y1988 y1989 y1990 y1991 y1992 y1993 y1994 y1995 y1996 y1997 y1998 y1999 y2000 y2001 y2002 y2003 y2004 y2005 y2006 y2007 y2008 y2009 y2010 y2011 y2012 y2013 y2014 y2015
% indx=find(strncmp(applicant_name,'IBM',3))


yr0=1899;
yrs=(1960:2013)'; % Years we care about
yy=yrs-yr0;

TotalSemi=sum(citations_semi);
citations_both=citations_semi+citations_non;

% Percent of firms citations that are due to semiconductors
citations_pct_own = 100*citations_semi./citations_both; 

% Percent of years total semiconductor citations summed over all firms due to firm i
citations_pct_all = 100*div(citations_semi,TotalSemi);  


% Collect all firms that have some year in yrs with citations_pct_all > CitationCutoff
CitationCutoff = .05*100
MeetsCutoff_it = citations_pct_all >= CitationCutoff;
MeetsCutoff = find(any(MeetsCutoff_it'==1)');
[blah indx]=sort(citations_pct_all(MeetsCutoff,1980-yr0),'descend');

KeyYears=[1970 1975 1980 1990 2000 2010];
tle='1970 1975 1980 1990 2000 2010';
disp 'Citations_pct_all for firms with more than CitationCutoff percent in any year, sorted by 1980';
cshow(applicant_name(MeetsCutoff(indx)),citations_pct_all(MeetsCutoff(indx),KeyYears-yr0),'%10.2f',tle)

disp ' ';
NN=length(MeetsCutoff);
fprintf('   Number of firms = %4.0f\n',NN);


% Companies to consolidate because they are the same firm
ToMergeData=[
0	1	% HITACHI
0	1	% FUJITSU
0	1	% TOSHIBA CORPORATION
0	1	% IBM (INTERNATIONAL BUSINESS MACHINES CORPORATION)
0	1	% NEC CORPORATION
0	1	% MITSUBISHI ELECTRIC CORPORATION
1	1	% SIEMENS
0	1	% BELL LABORATORIES
0	1	% RCA CORPORATION (RADIO CORPORATION OF AMERICA)
0	1	% TEXAS INSTRUMENTS
2	0	% U.S. PHILIPS CORPORATION
0	1	% GE (GENERAL ELECTRIC COMPANY)
2	1	% PHILIPS ELECTRONICS
0	1	% WESTERN ELECTRIC COMPANY
0	1	% MOTOROLA
0	1	% HUGHES AIRCRAFT COMPANY
0	1	% WESTINGHOUSE ELECTRIC CORPORATION
0	1	% LICENTIA PATENT-VERWALTUNGS-GESELLSCHAFT
0	1	% EATON CORPORATION
0	1	% HONEYWELL INTERNATIONAL
2	0	% NORTH AMERICAN PHILIPS COMPANY
0	1	% SEMICONDUCTOR ENERGY LABORATORY COMPANY
0	1	% GM (GENERAL MOTORS CORPORATION)
1	0	% SIEMENS-SCHUCKERTWERKE
2	0	% PHILIPS INTELLECTUAL PROPERTY & STANDARDS
0	1	% INTERNATIONAL STANDARD ELECTRIC CORPORATION
3	1	% FAIRCHILD CAMERA AND INSTRUMENT CORPORATION
0	1	% STANDARD TELEPHONES AND CABLES
0	1	% TELEFONAKTIEBOLAGET LM ERICSSON (PUBL)
0	1	% BATTELLE MEMORIAL INSTITUTE
0	1	% BOE TECHNOLOGY GROUP COMPANY
3	0	% FAIRCHILD SEMICONDUCTOR CORPORATION
0	1	% INTERNATIONAL TELEPHONE AND TELEGRAPH CORPORATION
0	1	% MICRON TECHNOLOGY
0	1	% PATENT-TREUHAND-GESELLSCHAFT FUER ELEKTRISCHE GLUEHLAMPEN
0	1	% PHILCO CORPORATION
0	1	% PURDUE RESEARCH FOUNDATION
4	0	% SAMSUNG DISPLAY
4	1	% SAMSUNG ELECTRONICS COMPANY
1	0	% SIEMENS & HALSKE
0	1	% SYLVANIA ELECTRIC PRODUCTS
0	1	% TAIWAN SEMICONDUCTOR MANUFACTURING COMPANY
  ];
ToMerge=ToMergeData(:,1);
ToKeep =ToMergeData(:,2);

Citations_pct_own=citations_pct_own; % Capital letter handles the merge
Citations_pct_all=citations_pct_all;

for i=1:max(ToMerge);
    isame=find(ToMerge==i);
    applicant_name(MeetsCutoff(indx(isame)))
    i_orig=MeetsCutoff(indx(isame)); % The original pointers to these same companies
                                 
    for j=1:length(i_orig); % Replace all orig with the sum across the same companies
        Citations_pct_own(i_orig(j),:)=100*sum(citations_semi(i_orig,:))./sum(citations_both(i_orig,:));
        Citations_pct_all(i_orig(j),:)=100*div(sum(citations_semi(i_orig,:)),TotalSemi);
    end;
end;

for i=1:NN; % Delete the duplicates (NaN)
    if ToKeep(i)==0;
        Citations_pct_own(MeetsCutoff(indx(i)),:)=NaN;
        Citations_pct_all(MeetsCutoff(indx(i)),:)=NaN;
    end;
end;

disp ' '; disp ' ';
disp '------------------------------';
disp 'After Merging subsidiaries...'
disp '------------------------------';
disp 'Citations_pct_all for firms with more than CitationCutoff percent in any year, sorted by 1980';
cshow(applicant_name(MeetsCutoff(indx)),Citations_pct_all(MeetsCutoff(indx),KeyYears-yr0),'%10.2f',tle)


% And finally resorting to drop the duplicates
MeetsCutoff_it = Citations_pct_all >= CitationCutoff;
MeetsCutoff = find(any(MeetsCutoff_it'==1)');
[blah indx]=sort(Citations_pct_all(MeetsCutoff,1980-yr0),'descend');

disp ' '; disp ' ';
disp 'Citations_pct_all for firms with more than CitationCutoff percent in any year, sorted by 1980';
cshow(applicant_name(MeetsCutoff(indx)),Citations_pct_all(MeetsCutoff(indx),KeyYears-yr0),'%10.2f',tle)

disp ' '; disp ' ';
disp 'Citations_pct_own for firms with more than CitationCutoff percent in any year, sorted by 1980 pct_all';
cshow(applicant_name(MeetsCutoff(indx)),Citations_pct_own(MeetsCutoff(indx),KeyYears-yr0),'%10.2f',tle)

disp ' ';
NN=length(MeetsCutoff);
fprintf('   Number of firms = %4.0f\n',NN);



% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot and smooth semiconductor share of own patents
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
definecolors
HPParam=100
cites_smoothed=zeros(length(yrs),NN)*NaN;
cites_own = Citations_pct_own(MeetsCutoff(indx),yrs-yr0)';
cites_own(isnan(cites_own))=0; % Replace NaNs with zero to help hpfilter
Name=applicant_name(MeetsCutoff(indx));
delete('ReadCitationData.ps');
warning off
for i=1:NN;
    sfigure(1); clf; hold on;
    cites_smoothed(:,i)=hpfilter(cites_own(:,i),HPParam);
    cites_smoothed(cites_smoothed<0)=0; % Replace negatives with 0 in smoothed
    plot(yrs,cites_own(:,i),'-','Color',myblue);
    plot(yrs,cites_smoothed(:,i),'-','Color',myred);
    chadfig2(' ','Semi share of own citations',1,0);
    title(Name(i),'FontName','Helvetica','FontSize',11);
    print('-dpsc','-append','ReadCitationData');
    %wait
end;
warning on

shortnames='Year Hitachi Fuji Toshiba IBM NEC Mitsu Siemens AT&T RCA TI Philips GE Western Motorola Hughes WestingH Licentia Eaton Honey SELC GM IntlStd Fairchild Standard Ericsson Battelle BOE ITT Micron Glue Philco Purdu Samsung Sylvania TSMC';

disp ' '; disp ' ';
disp 'Smoothed Semiconductor share of own citations -- for merging R&D';
cshow(' ',[yrs cites_smoothed],'%6.0f %10.2f',shortnames)

% Sorting
disp ' '; disp ' ';
sortnames='Year Fairchild AT&T GE IBM Philips Motorola RCA TI Hitachi Toshiba Fuji NEC Mitsu Siemens Samsung Western Hughes WestingH Licentia Eaton Honey SELC GM IntlStd Standard Ericsson Battelle BOE ITT Micron Glue Philco Purdu Sylvania TSMC';
order=[9 11 10 4 12 13 14 2 7 8 6 3 16 6 17 18 19 20 21 22 23 24 1 25 26 27 28 29 30 31 32 33 15 34 35];
disp 'Smoothed Semiconductor share of own citations -- for merging R&D';
cshow(' ',[yrs cites_smoothed(:,order)],'%6.0f %10.2f',sortnames)


diary off;

% Other company TIC codes for Compustat
% HTHIY FJTSY TOSYY IBM NIPNY MIELY SIEGY T T1 T.2 RCA.1 TXN PHG PHG1 GE PHG PHG1 MSI

