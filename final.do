/*
This program is for ECO 480 TFINAL PROJECT
Last modified by:Hao Wu
Last modified on: MAY 12, 2021
*/
clear all
cd "/Applications/Stata/ECO 480"

set more off
capture log close
log using Empirical_Project_Hao_Wu.log, replace

use ecls_5th_grade.dta, clear
sum
asdoc sum
describ
egen total_grade = rowtotal(reading_test math_test science_test)
egen extra_activity = rowmax(part_dance part_athletics part_club part_music part_art)
egen problem = rowmax(problem_crowding problem_turnover problem_parents problem_drugs problem_gangs problem_crime problem_weapons problem_attacks)
gen tv_activity = 0 
replace tv_activity = 1 if tv_afternoon_mf !=0 
replace tv_activity = 1 if tv_afterdinner_mf !=0 
replace tv_activity = 1 if tv_saturday !=0
replace tv_activity = 1 if tv_sunday !=0

regress total_grade extra_activity problem tv_activity mom_curr_married,robust
outreg2 using myreg.doc,replace

regress total_grade mom_curr_married,robust
outreg2 using myreg.doc,replace

regress total_grade school_type,robust

regress total_grade part_dance part_athletics part_club part_music part_art,robust
outreg2 using myreg.doc, append

regress total_grade problem_crowding problem_turnover problem_parents problem_drugs problem_gangs problem_crime problem_weapons problem_attacks,robust
outreg2 using myreg.doc, append


regress total_grade mom_curr_married part_athletics part_club part_music problem_turnover problem_parents problem_drugs problem_gangs problem_weapons problem_attacks school_type,robust
outreg2 using myreg.doc, append

xtset race
xtreg total_grade mom_curr_married part_athletics part_club part_music problem_turnover problem_parents problem_drugs problem_gangs problem_weapons problem_attacks school_type,fe vce(cluster race)
outreg2 using myreg.doc, replace
xtset region
xtreg total_grade mom_curr_married part_athletics part_club part_music problem_turnover problem_parents problem_drugs problem_gangs problem_weapons problem_attacks school_type,fe vce(cluster region)
outreg2 using myreg.doc, append

log close






