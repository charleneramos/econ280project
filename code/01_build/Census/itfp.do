clear all
cap log close
set more off
*** READ IN CMF'S
foreach y of numlist 1972(5)2012 {
	u "$asmcmf/cmf`y'", clear
	* MERGE TO TFP FILES
	merge 1:1 survu_id year using "$asmcmf/cmf`y'tfp"
		drop if _merge==2
		drop _merge
	tempfile `y'
	save ``y''
}
* APPEND FILES AND CREATE PANEL
clear
foreach y of numlist 1972(5)2012 {
	append using ``y''
}
* COLLAPSE FROM ESTABLISHMENT TO FIRM
gen mywt=te
gen estabs=1
collapse (rawsum) va te kst* tvs estabs (mean) ltfp [aw=mywt], by(firmid year)	// firm tfp is employment-weighted mean of estab tfp
* MERGE TO SIRD/BRDIS FILES
merge 1:1 firmid year using "$brdis/rnd_matched", keepusing(set rnd)			// BRDIS/SIRD already matched and cleaned by Brian
	drop _merge																	// Don't drop unmatched yet as need intercensal years to sum rnd over last 5/10 years, etc.
replace rnd=0 if rnd==.
replace set=0 if set==.
* MERGE IN DEFLATORS
merge m:1 year using "rnd_deflator"
	keep if _merge==3
	drop _merge
merge m:1 year using "gdp_deflator"
	keep if _merge==3
	drop _merge
* DEFLATE
replace rnd=rnd*rnd_deflator
replace tvs=tvs*gdp_deflator
replace va=va*gdp_deflator
* SUM RND SPENDING/SCIENTIST EMPLOYMENT OVER LAST 5/10 YEARS
tsset firmid year
forv L=1/20 {
	gen L`L'_rnd=L`L'rnd
	gen L`L'_set=L`L'set
}
foreach var in rnd set {
egen m10`var'=rsum(L1_`var' L2_`var' L3_`var' L4_`var' L5_`var' L6_`var' L7_`var' L8_`var' L9_`var' L10_`var')
	replace m10`var'=m10`var'/10
egen m20`var'=rsum(L1_`var' L2_`var' L3_`var' L4_`var' L5_`var' L6_`var' L7_`var' L8_`var' L9_`var' L10_`var'	///
				L11_`var' L12_`var' L13_`var' L14_`var' L15_`var' L16_`var' L17_`var' L18_`var' L19_`var' L20_`var')
	replace m20`var'=m20`var'/20
}
* GENERATE REAL SALES GROWTH
gen d10tvs=(tvs-L10.tvs)/(0.5*tvs+0.5*L10.tvs)
* RESEARCH INPUT GROWTH RATES
gen d10rnd=(m10rnd-L10.m10rnd)/(0.5*m10rnd+0.5*L10.m10rnd)
gen d10set=(m10set-L10.m10set)/(0.5*m10set+0.5*L10.m10set)
* KEEP ONLY CENSUS YEARS
keep if mod(year,5)==2
* IDEAS TFP = (DELTA REAL SALES)/(RESEARCH EFFORT)
foreach y in rnd set {
	gen itfp10_tvs_`y'=d10tvs/m10`y'
}
* IDEAS TFP GROWTH - (10-year percent change)
foreach y in rnd set {
	gen d10itfp_tvs_`y'=(itfp10_tvs_`y'/L10.itfp10_tvs_`y' - 1)
}
* WINSORIZE IDEA TFP FROM BELOW AT 1%
gen winsorized=(itfp10_tvs_rnd<0.01)
count if winsorized==1
local NF=r(N)																	// get # of firms winsorized
gen itfp10_tvs_rnd_w1=itfp10_tvs_rnd
replace itfp10_tvs_rnd_w1=0.01 if itfp10_tvs_rnd_w1<0.01
* WINSORIZE EQUAL NUMBER OF FIRMS AT TOP OF DISTRIBUTION
gen itfp10_tvs_rnd_w1wX=itfp10_tvs_rnd_w1
gsort -itfp10_tvs_rnd_w1wX														// sort highest to lowest
su itfp10_tvs_rnd_w1wX if _n==`NF'+1											// itfp value at Nth+1 from top of distribution
replace itfp10_tvs_rnd_w1wX=r(mean) if _n<=`NF'									// repalce 1st through Nth highest with Nth+1's value
* IDEAS TFP GROWTH FOR THESE ALTERNATE MEASURES
gen d10itfp_tvs_rnd_w1=(itfp10_tvs_rnd_w1/L10.itfp10_tvs_rnd_w1 - 1)
gen d10itfp_tvs_rnd_w1wX=(itfp10_tvs_rnd_w1wX/L10.itfp10_tvs_rnd_w1wX - 1)
* TABLE CALCULATIONS
*** (1) REAL SALES GROWTH/R&D EXPENDITURES, WEIGHTED BY MEAN R&D OVER LAST 10 YEARS
su d10itfp_tvs_rnd [aw=m10rnd], de
	di 1/(1-r(mean)) 															// FACTOR DECREASE
	di 1-(1-r(mean))^0.1 														// AVERAGE GROWTH
*** (2) ...ITFP WINSORIZED FROM BELOW AT 1%
su d10itfp_tvs_rnd_w1 [aw=m10rnd], de
	di 1/(1-r(mean)) 															// FACTOR DECREASE
	di 1-(1-r(mean))^0.1 														// AVERAGE GROWTH
*** (3) ...ITFP WINSORIZED FROM BELOW AT 1% AND EQUAL # FIRMS WINSORIZED FROM ABOVE
su d10itfp_tvs_rnd_w1wX [aw=m10rnd], de
	di 1/(1-r(mean)) 															// FACTOR DECREASE
	di 1-(1-r(mean))^0.1 														// AVERAGE GROWTH
*** (4) ...UNWEIGHTED
su d10itfp_tvs_rnd, de
	di 1/(1-r(mean)) 															// FACTOR DECREASE
	di 1-(1-r(mean))^0.1 														// AVERAGE GROWTH
*** (5) ...DENOMINATOR IS SCIENTISTS' EMPLOYMENT
su d10itfp_tvs_set [aw=m10rnd], de
	di 1/(1-r(mean)) 															// FACTOR DECREASE
	di 1-(1-r(mean))^0.1 														// AVERAGE GROWTH
*** (6) GROWTH RATE OF R&D, WEIGHTED BY MEAN R&D OVER LAST 20 YEARS
su d10rnd [aw=m20rnd], de
	di 1/(1-r(mean)) 															// FACTOR DECREASE
	di 1-(1-r(mean))^0.1 														// AVERAGE GROWTH
*** (7) ...UNWEIGHTED
su d10rnd, de
	di 1/(1-r(mean)) 															// FACTOR DECREASE
	di 1-(1-r(mean))^0.1 														// AVERAGE GROWTH
*** (8) ...SCIENTISTS INSTEAD OF R&D EXPENDITURES
su d10set [aw=m20rnd], de
	di 1/(1-r(mean)) 															// FACTOR DECREASE
	di 1-(1-r(mean))^0.1 														// AVERAGE GROWTH












