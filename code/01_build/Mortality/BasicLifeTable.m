% BasicLifeTable.m   11/13/15 -- Both men and women
%
%  Read the basic life tables from Mortality.org
%  The United States of America, Life tables (period 1x1), Total     
%        Last modified: 21-Jul-2015, MPv5 (May07)
%
%   Age   Age group for n-year interval from exact age x to just before exact age x+n, where n=1, 4, 5, or ∞ (open age interval)
%   m(x)  Central death rate between ages x and x+n
%   q(x)  Probability of death between ages x and x+n
%   a(x)  Average length of survival between ages x and x+n for persons dying in the interval
%   l(x)  Number of survivors at exact age x, assuming l(0) = 100,000
%   d(x)  Number of deaths between ages x and x+n
%   L(x)  Number of person-years lived between ages x and x+n
%   T(x)  Number of person-years remaining after exact age x
%   e(x)  Life expectancy at exact age x (in years)
%
%  Years = 1933 to 2013
%  Age   = 0 to 110+ (recorded as 110)
%
%   Year          Age         mx       qx    ax      lx      dx      Lx       Tx     ex
%   1933           0     0.05177  0.04971  0.20  100000    4971   96013  6296047  62.96
%   1933           1     0.00874  0.00871  0.50   95029     827   94615  6200033  65.24
%   1933           2     0.00404  0.00403  0.50   94202     380   94012  6105418  64.81
%    ...
%   2000          50     0.00319  0.00319  0.50   95445     304   95293  3029421  31.74
%   2000          65     0.01268  0.01260  0.50   86533    1091   85987  1650493  19.07
%
% Main statistics I need are Life expectancy and 
%   total death rate (age-adjusted) for Ages 50+ and 65+
%
%   Age-adjust based on the year 2000
%     -- Add up lx in the year 2000 to get a total number of people N (e.g. > age 50)
%     -- Compute age distribution as weight:=lx/N, which sums to 1.
%     -- qx = death rate at each age (also = dx/lx)
%     -- Compute age-adjusted average death rate as Sum(qx*weight)
%     This gives the average age-adjusted death rate for ages 50+...

clear;
diarychad('BasicLifeTable');
definecolors;

load Mortality.org.LifeTable1x1.txt  % Both sexes
x=Mortality_org_LifeTable1x1;
[N,cols]=size(x);
Nages=111;   % Ages 0 to 110+
Nyears=N/Nages;

vars=strmat('Year Age mx qx ax lx dx Lx Tx ex');
Year=reshape(x(:,1),Nages,Nyears);
Age=reshape(x(:,2),Nages,Nyears);
mx=reshape(x(:,3),Nages,Nyears);
qx=reshape(x(:,4),Nages,Nyears);
ax=reshape(x(:,5),Nages,Nyears);
lx=reshape(x(:,6),Nages,Nyears);
dx=reshape(x(:,7),Nages,Nyears);
Lx=reshape(x(:,8),Nages,Nyears);
Tx=reshape(x(:,9),Nages,Nyears);
ex=reshape(x(:,10),Nages,Nyears);
Years=Year(1,:)';
Age=Age(:,1)';


% Total LE and death rate (age-adjusted) for Ages 50+ and 65+  and 65-74
%   Age-adjust based on the year 2000
%     -- Add up lx in the year 2000 to get a total number of people N (e.g. > age 50)
%     -- Compute age distribution as weight2000:=lx/N, which sums to 1.
%     -- qx = death rate at each age (also = dx/lx)
%     -- ex = life expectancy at each age
%     -- Compute age-adjusted average death rate in each year as Sum(qx*weight2000)
%        and ditto for life expectancy Sum(ex*weight2000)
%     This gives the average age-adjusted death rate and life expectancy for ages 50+...

yr0=Years(1)-1;
yr2000=2000-yr0;

% Age 50+
ages=(50:110)+1; % since starts at age=0;
Npeople=sum(lx(ages,yr2000));
weight2000=lx(ages,yr2000)/Npeople;
qx50=sum(mult(qx(ages,:),weight2000))';
ex50=sum(mult(ex(ages,:),weight2000))';
fmt='%6.0f %12.4f %12.4f %12.4f %12.2f %12.2f %12.2f';
cshow(' ',[Years qx(51,:)' qx(71,:)' qx50 ex(51,:)' ex(71,:)' ex50],fmt,'Year qx(age50) qx(age70) qx50+ ex(age50) ex(age70) ex50+');

% Another way to check: figure out death rate in 2000 = total deaths / total people.
% This should give the same answer in the year 2000!
fprintf('    Deaths in 2000 of people 50+ = %8.0f\n',sum(dx(ages,yr2000)));
fprintf('Population in 2000 of people 50+ = %8.0f\n',sum(lx(ages,yr2000)));
fprintf('      Implied death rate = %12.6f\n',sum(dx(ages,yr2000))/sum(lx(ages,yr2000)));
fprintf('  Versus our calculation = %12.6f\n',qx50(yr2000));
disp 'These last two numbers should be the same!';


% Age 65+
ages=(65:110)+1; % since starts at age=0;
Npeople=sum(lx(ages,yr2000));
weight2000=lx(ages,yr2000)/Npeople;
qx65=sum(mult(qx(ages,:),weight2000))';
ex65=sum(mult(ex(ages,:),weight2000))';
fmt='%6.0f %12.4f %12.4f %12.4f %12.2f %12.2f %12.2f';
cshow(' ',[Years qx(66,:)' qx(81,:)' qx65 ex(66,:)' ex(81,:)' ex65],fmt,'Year qx(age65) qx(age80) qx65+ ex(age65) ex(age80) ex65+');

% Another way to check: figure out death rate in 2000 = total deaths / total people.
% This should give the same answer in the year 2000!
fprintf('    Deaths in 2000 of people 65+ = %8.0f\n',sum(dx(ages,yr2000)));
fprintf('Population in 2000 of people 65+ = %8.0f\n',sum(lx(ages,yr2000)));
fprintf('      Implied death rate = %12.6f\n',sum(dx(ages,yr2000))/sum(lx(ages,yr2000)));
fprintf('  Versus our calculation = %12.6f\n',qx65(yr2000));
disp 'These last two numbers should be the same!';



% Age 65-74
ages=(65:74)+1; % since starts at age=0;
Npeople=sum(lx(ages,yr2000));
weight2000=lx(ages,yr2000)/Npeople;
qx65_74=sum(mult(qx(ages,:),weight2000))';
ex65_74=sum(mult(ex(ages,:),weight2000))';
fmt='%6.0f %12.4f %12.4f %12.4f %12.2f %12.2f %12.2f';
cshow(' ',[Years qx(66,:)' qx(75,:)' qx65_74 ex(66,:)' ex(75,:)' ex65_74],fmt,'Year qx(age65) qx(age74) qx65_74 ex(age65) ex(age74) ex65_74');

% Another way to check: figure out death rate in 2000 = total deaths / total people.
% This should give the same answer in the year 2000!
fprintf('    Deaths in 2000 of people 65-74 = %8.0f\n',sum(dx(ages,yr2000)));
fprintf('Population in 2000 of people 65-74 = %8.0f\n',sum(lx(ages,yr2000)));
fprintf('      Implied death rate = %12.6f\n',sum(dx(ages,yr2000))/sum(lx(ages,yr2000)));
fprintf('  Versus our calculation = %12.6f\n',qx65_74(yr2000));
disp 'These last two numbers should be the same!';



% Save the results
qx_AllCauses_50over=qx50;
qx_AllCauses_65over=qx65;
qx_AllCauses_65_74=qx65_74;
ex_50over=ex50;
ex_65over=ex65;
ex_65_74=ex65_74;
YearsAllCauses=Years;

% Life expectancy at 50 and 65 (easy!) 

save BasicLifeTable qx_AllCauses_50over qx_AllCauses_65over qx_AllCauses_65_74 YearsAllCauses ex_50over ex_65over ex_65_74;


% Plots to show basic facts
LW=4;
figure(1); figsetup;
h1=plotlog(Age(1:110),qx(1:110,yr2000),'-','0.001 0.004 0.016 0.064 0.256 1.0');
set(h1,'LineWidth',LW);
chadfig2('Age','Mortality rate, 2000',1,0);
makefigwide;
%title('Gompertz Law');
g=mean(delta(log(qx((25:90)+1,yr2000))));
s1=sprintf('Average growth rate of mortality ages 25 and 90 is %7.4f',g);
s2=sprintf('  so mortality rates double every %3.1f years of age',.72/g);
text(40,log(0.0004),s1);
text(40,log(0.00025),s2);
print BasicLifeTable1.eps

figure(2); figsetup;
h2=plotlog(Years,qx(65+1,:),'-','0.002 0.004 0.008 0.016 0.032 0.064');
set(h2,'LineWidth',LW);
hold on;
plot(Years,log(qx(50+1,:)),'-','Color',mygreen,'LineWidth',LW);
chadfig2('Year','Mortality rate, 2000',1,0);
makefigwide;
text(1990,log(0.024),'Age 65');
text(1990,log(0.0055),'Age 50');
print BasicLifeTable2.eps


diary off;
