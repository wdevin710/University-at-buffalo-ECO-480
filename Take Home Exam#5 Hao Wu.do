/*
This program is for ECO 480 Take Home Exam#5
Last modified by:Hao Wu
Last modified on: Apr 21, 2021
*/
clear all
cd "D:\stata\ECO 480"

set more off
capture log close
log using Take_Home_Exam#5_Hao_Wu.log, replace

use PresApproval.dta, replace
desc
summarize 
regress PresApprov UnemPct, robust
regress PresApprov UnemPct South, robust
regress PresApprov UnemPct i.StCode, robust
regress PresApprov UnemPct South i.StCode, robust

reg PresApprov UnemPct i.StCode Year,vce(cluster StCode)


import delimited Income_Democracy.csv, clear
summarize 
desc
list dem_ind year if country == "United States"
list dem_ind year if country == "Libya"
bysort country: egen mean = mean(dem_ind)
list country if mean > 0.95
list country if mean < 0.10
list country if mean > 0.3 & mean < 0.7

reg dem_ind log_gdppc, robust
reg dem_ind log_gdppc educ, robust
reg dem_ind log_gdppc year, vce(cluster code)
xtset code year
xtreg dem_ind log_gdppc log_pop age_1 age_2 age_3 age_4 age_5 educ $yeardum, fe vce(cluster code)










log close