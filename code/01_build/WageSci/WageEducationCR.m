% WageEducation.m
%
%   Mean personal income from CPS (Census Tables P18 and P19)
%   for males with 4 or more years of college (or post college).
%    -- See WageSci/MeanIncomebyEducation-CPS.xls
%
%   Note well: Any wage program should save the following three variables
%     WageYears= e.g. (1929:2015)'
%     WageScientist=NominalGDPperPerson;
%     WageNotes={'Currently using Nominal GDP per Person from NIPA for the wage deflator'}
%   into the .mat file WageScientistData.mat
%
%   That way we can easily change the wage deflator by just running a different wage program
%   and then rerunning the idea TFP programs.
%
%   For Gordon: extrapolated before 1939 using Nominal GDP per person

clear;
diarychad('WageEducation');


eddata=[
1929	2599
1930	2266
1931	1887
1932	1442
1933	1378
1934	1599
1935	1766
1936	2005
1937	2184
1938	2036
1939	2163
1949	4554
1956	7877
1958	8643
%1959	NaN
1961	9817
1963	9811
1964	10284
1966	11739
1967	11924
1968	12938
1969	14079
1970	14434
1971	15133
1972	16201
1973	17064
1974	18265
1975	19111
1976	20516
1977	22125
1978	23724
1979	25544
1980	27216
1981	29278
1982	31055
1983	32472
1984	34736
1985	37570
1986	39773
1987	40840
1988	42861
1989	46932
1990	46961
1991	62450
1992	61130
1993	76840
1994	77150
1995	72830
1996	81270
1997	89480
1998	85530
1999	98890
2000	91730
2001	96330
2002	97140
2003	91170
2004	103900
2005	103200
2006	115700
2007	109000
2008	111800
2009	113300
2010	113400
2011	115800
2012	125800
2013	128100
2014	118000
2015  124500  % Rough estimate. Used in Compustat work. Need better #
];

edyrs=eddata(:,1);
edwage=eddata(:,2);

% First, let's interpolate log-linearly to get missing years.
% Only affects old data that we almost never use (except Gordon's decades)
% so that should be okay.

[lnwage,years]=interplin2(log(edwage),edyrs);
WageScientist=exp(lnwage);
WageYears=years;
WageNotes={
    'Currently using Mean Personal Income for Males with 4+ years of college'}

disp 'Earnings Data (college grads)';
cshow(' ',[WageYears WageScientist],'%8.0f');


save WageScientistDataCR WageYears WageScientist WageNotes;
writematrix(WageScientist, "WageScientistCR.xlsx")
diary off;