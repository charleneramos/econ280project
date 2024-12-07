% LifeExpectancy   2/28/15
%
%  Life expectancy, at birth and at age 65
%  See Life-ExpectancyAggregateData.xls
%   -- Data from https://www.clio-infra.eu/datasets/transfer/zip3969638
%      and Health, United States 2013, vol 63 no 3. Hyattsville, MD: NCHS; 2014. Available from: http://www.cdc.gov/nchs/data/nvsr/nvsr63/nvsr63_03.pdf.


diarychad('LifeExpectancy');
definecolors;

% From Health, United States 2013
data65=[
1950	13.9
1960	14.3
1970	15.2
1975	16.1
1980	16.4
1981	16.6
1982	16.8
1983	16.7
1984	16.8
1985	16.7
1986	16.8
1987	16.9
1988	16.9
1989	17.1
1990	17.2
1991	17.4
1992	17.5
1993	17.3
1994	17.4
1995	17.4
1996	17.5
1997	17.7
1998	17.8
1999	17.7
2000	17.6
2001	17.9
2002	17.9
2003	18.1
2004	18.4
2005	18.4
2006	18.7
2007	18.8
2008	18.8
2009	19.1
2010	19.1
2011	19.2
];

yrs65=data65(:,1);
e65=data65(:,2);

% From Clio
data0=[
1900	49.3
1901	50.5
1902	50.6
1903	49.6
1904	50.3
1905	50.1
1906	50.2
1907	51.9
1908	52.8
1909	51.8
1910	53.4
1911	54.1
1912	53.5
1913	54.6
1914	55.1
1915	54.2
1916	54
1917	47.2
1918	55.3
1919	55.4
1920	58.2
1921	58.1
1922	57.5
1923	58.5
1924	58.5
1925	57.9
1926	59.4
1927	58.3
1928	58.5
1929	59.6
1930	60.3
1931	61
1932	60.88
1933	60.23
1934	60.89
1935	60.35
1936	61.05
1937	62.39
1938	63.07
1939	63.23
1940	63.8
1941	64.59
1942	64.3
1943	65.09
1944	65.58
1945	66.28
1946	66.69
1947	67.25
1948	67.63
1949	68.07
1950	68.17
1951	68.39
1952	68.72
1953	69.5
1954	69.56
1955	69.64
1956	69.41
1957	69.67
1958	69.89
1959	69.83
1960	70.24
1961	70.11
1962	69.94
1963	70.19
1964	70.24
1965	70.21
1966	70.52
1967	70.22
1968	70.48
1969	70.74
1970	71.09
1971	71.18
1972	71.4
1973	71.97
1974	72.54
1975	72.85
1976	73.22
1977	73.42
1978	73.83
1979	73.74
1980	74.12
1981	74.47
1982	74.56
1983	74.69
1984	74.67
1985	74.75
1986	74.88
1987	74.86
1988	75.14
1989	75.41
1990	75.56
1991	75.81
1992	75.61
1993	75.78
1994	75.89
1995	76.22
1996	76.54
1997	76.71
1998	76.73
1999	76.87
2000	76.98
2001	77.05
2002	77.21
2003	77.62
2004	77.62
2005	77.91
2006	78.17
2007	78.26
2008	78.63
2009	78.83
2010	78.7
];

yrs=data0(:,1);
e0=data0(:,2);

Change65=(e65(end)-e65(1))/(yrs65(end)-yrs65(1))*10;
indx=find(yrs==1950);
Change0=(e0(end)-e0(indx))/(yrs(end)-yrs(indx))*10;
Change0pre=(e0(indx)-e0(1))/(yrs(indx)-yrs(1))*10;

disp ' '
fprintf('Average change in Life Expectancy at birth  pre- 1950 = %5.3f years per decade\n',Change0pre);
fprintf('Average change in Life Expectancy at birth since 1950 = %5.3f years per decade\n',Change0);
fprintf('Average change in Life Expectancy at 65    since 1950 = %5.3f years per decade\n',Change65);
disp ' ';

figure(1); figsetup;
% plot(yrs,e0,'-','Color',myblue,'LineWidth',4);
% plot(yrs65,e65,'-','Color',mygreen,'LineWidth',4);
% chadfig2('Year','Life expectancy',1,0);

[ax,h1,h2]=plotyy(yrs,e0,yrs65,e65);
darkfactor=.8;
set(h1,'LineWidth',LW,'Color',myblue);
set(h2,'LineWidth',LW,'Color',mygreen);
set(ax(1),'ycolor',myblue*darkfactor);
set(ax(2),'ycolor',mygreen*darkfactor);


%a1=axis(ax(1)); a1(3)=-3; a1(2)=2014; axis(ax(1),a1);
%a2=axis(ax(2)); a2(3)=37; a2(2)=2014; axis(ax(2),a2);
set(ax(1),'Box','off');
set(ax(2),'Box','off');
makefigwide;
str=mlstring('At birth\\    (left scale)');
text(1940,74,str);
str=mlstring('At age 65\\   (right scale)');
text(1978,58,str);
set(ax(2),'XLim',[1900 2014]);
set(ax(1),'XLim',[1900 2014]);
chadfig2(' ','Years',1,0);
chadfigyy(ax(2),'Years');
print('-depsc','LifeExpectancy');