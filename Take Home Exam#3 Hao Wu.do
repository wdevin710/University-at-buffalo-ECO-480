/*
This program is for ECO 480 Take Home Exam#2
Last modified by:Hao Wu
Last modified on: Mar 30th, 2021
*/
clear all
cd "D:\stata\ECO 480"

set more off
capture log close
log using Take_Home_Exam#3_Hao_Wu.log, replace

use height_wages, replace
regress wage96 height85
eststo wage96_height85
esttab wage96_height85 using wage96_height85_regress.rtf,p replace

regress wage96 height85 height81
eststo wage96_height85_height81
esttab wage96_height85_height81 using wage96_height85_height81_regress.rtf,p replace

twoway scatter height81 height85
graph export box_height81_height85.png,replace
twoway scatter height81 height85, jitter(5)
graph export box_height81_height85_jitter.png,replace

regress height81 height85

regress wage96 male height81 height85 
eststo gender_wage
esttab gender_wage using gender_wage_regress.rtf,p replace

regress wage96 height81 height85 if male == 1
eststo male_wage
esttab male_wage using male_wage_regress.rtf,p replace
regress wage96 height81 height85 if male == 0
eststo female_wage
esttab female_wage using female_wage_regress.rtf,p replace

gen female = male
replace female = 1 if male == 0 

gen regions = 0
replace regions = 1 if norcen96 == 1
replace regions = 2 if south96 == 1
replace regions = 3 if west96 == 1
replace regions = . if missing(norest96)

regress wage96 male regions if regions != 3
eststo wage_region
esttab wage_region using wage_region_regress.rtf,p replace

regress wage96 male regions if regions != 2
eststo wage_region2
esttab wage_region2 using wage_region2_regress.rtf,p replace

regress wage96 athlets if male == 1
eststo wage_athlets
esttab wage_athlets using wage_athlets_regress.rtf,p replace

use cellphone_2012, replace

regress numberofdeaths cell_subscription
eststo death_cell
esttab death_cell using death_cell_regree.rtf,p replace

regress numberofdeaths cell_subscription population
eststo death_cell_population
esttab death_cell_population using death_cell_population_regree.rtf,p replace

regress numberofdeaths cell_subscription population total_miles_driven
eststo death_cell_population_mile
esttab death_cell_population_mile using death_cell_population_mile_regree.rtf,p replace

use Growth, replace
drop if country_name == "Malta"
regress growth tradeshare yearsschool rev_coups assasinations rgdp60
eststo growth_all
esttab growth_all using gwoth_all_regress.rtf,p replace


log close

