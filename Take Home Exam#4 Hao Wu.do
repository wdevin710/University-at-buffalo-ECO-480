/*
This program is for ECO 480 Take Home Exam#2
Last modified by:Hao Wu
Last modified on: Apr 1st, 2021
*/
clear all
cd "D:\stata\ECO 480"

set more off
capture log close
log using Take_Home_Exam#4_Hao_Wu.log, replace



use fed_2012.dta, replace
twoway scatter FEDFUNDS election if democrat == 0 || scatter FEDFUNDS election if democrat == 1, legend(label(1 Republican) label(2 Democrat))
graph export democrat_republican.png, replace

generate ele_dem = democrat * election
regress FEDFUNDS democrat election ele_dem
eststo fed_regress_1
esttab fed_regress_1 using fed_regress_1.rtf,p replace

test ele_dem election

regress FEDFUNDS election if democrat == 0 
scatter FEDFUNDS election if democrat == 0 || lfit FEDFUNDS election if democrat == 0
regress FEDFUNDS election if democrat == 1
scatter FEDFUNDS election if democrat == 1 || lfit FEDFUNDS election if democrat == 1


import excel CPS2015.xlsx, clear

destring B C D E, replace force
rename (A B C D E) (YEAR AHE BACHELOR FEMALE AGE)
drop in 1

regress AHE FEMALE BACHELOR AGE, robust
dis "Adjusted Rsquared = " _result(8)
eststo first
esttab first using 1_regress.rtf,p replace

generate ln_AHE = ln(AHE)
regress ln_AHE FEMALE BACHELOR AGE, robust
dis "Adjusted Rsquared = " _result(8)
eststo second
esttab second using 2_lnregress.rtf,p replace

generate ln_AGE = ln(AGE)
regress ln_AHE FEMALE BACHELOR ln_AGE, robust
dis "Adjusted Rsquared = " _result(8)
eststo Third
esttab Third using 3_lnregress.rtf,p replace

generate AGE2= AGE*AGE
regress ln_AHE AGE AGE2 FEMALE BACHELOR, robust
dis "Adjusted Rsquared = " _result(8)
eststo Fourth
esttab Fourth using 4_lnregress.rtf,p replace

generate FEM_BAC = FEMALE*BACHELOR
regress ln_AHE AGE AGE2 FEMALE BACHELOR FEM_BAC, robust
dis "Adjusted Rsquared = " _result(8)
eststo Five
esttab Five using 5_lnregress.rtf,p replace

generate FEM_AGE = FEMALE*AGE
generate FEM_AGE2 = FEMALE*AGE2
regress ln_AHE AGE AGE2 FEM_AGE FEM_AGE2 FEMALE BACHELOR FEM_BAC, robust
dis "Adjusted Rsquared = " _result(8)
eststo Six
esttab Six using 6_lnregress.rtf,p replace
test AGE AGE2 FEM_AGE FEM_AGE2
test FEM_AGE FEM_AGE2

generate BAC_AGE = BACHELOR*AGE
generate BAC_AGE2 = BACHELOR*AGE2
regress ln_AHE AGE AGE2 BAC_AGE BAC_AGE2 FEMALE BACHELOR FEM_BAC, robust
dis "Adjusted Rsquared = " _result(8)
test AGE AGE2 BAC_AGE BAC_AGE2
test BAC_AGE BAC_AGE2
eststo seven
esttab seven using 7_lnregress.rtf,p replace

regress ln_AHE AGE AGE2 BAC_AGE BAC_AGE2 FEM_AGE FEM_AGE2 BACHELOR FEM_BAC, robust
dis "Adjusted Rsquared = " _result(8)
test FEM_AGE FEM_AGE2 BAC_AGE BAC_AGE2
eststo Eight
esttab Eight using 8_lnregress.rtf,p replace




log close