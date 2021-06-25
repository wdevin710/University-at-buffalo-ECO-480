/*
This program is for ECO 480 Take Home Exam#2
Last modified by:Hao Wu
Last modified on: Mar 8th, 2021
*/
clear all
cd "D:\stata\ECO 480"

set more off
capture log close
log using Take_Home_Exam#2_Hao_Wu.log, replace

import excel Dataset1.xlsx, clear //* Question 2 *//
regress B A 
eststo BA1 
esttab BA1 using XYREG.rtf ,replace

use Growth, replace //* Question 5 *//
sum growth tradeshare, detail
drop if country_name == "Malta"
regress growth tradeshare
eststo gtregress
esttab gtregress using gtregress5%.rtf,p replace
regress  growth tradeshare, level(90)
eststo gtregress90
esttab gtregress90 using gtregress10%.rtf,p replace
regress  growth tradeshare, level(99)
eststo gtregress99
esttab gtregress99 using gtregress1%.rtf,p replace
sum(tradeshare),detail

clear all
program OSL_SIM
	clear
	set obs 100
	gen Ed = 16*runiform()
	scalar SD = 10000
	gen Salary = 12000 + 1000*Ed + SD*rnormal()
	regress Salary Ed
end
simulate _b _se, reps(50):  OSL_SIM
list _b_* _se*
summarize _b*

clear all
program OSL_SIM
	clear
	set obs 1000
	gen Ed = 16*runiform()
	scalar SD = 10000
	gen Salary = 12000 + 1000*Ed + SD*rnormal()
	regress Salary Ed
end
simulate _b _se, reps(50):  OSL_SIM
list _b_* _se*
summarize _b*

clear all
program OSL_SIM
	clear
	set obs 20
	gen Ed = 16*runiform()
	scalar SD = 10000
	gen Salary = 12000 + 1000*Ed + SD*rnormal()
	regress Salary Ed
end
simulate _b _se, reps(50):  OSL_SIM
list _b_* _se*
summarize _b*

clear all
program OSL_SIM
	clear
	set obs 100
	gen Ed = 16*runiform()
	scalar SD = 500
	gen Salary = 12000 + 1000*Ed + SD*rnormal()
	regress Salary Ed
end
simulate _b _se, reps(50):  OSL_SIM
list _b_* _se*
summarize _b*

clear all
program OSL_SIM
	clear
	set obs 100
	gen Ed = 16*runiform()
	scalar SD = 50000
	gen Salary = 12000 + 1000*Ed + SD*rnormal()
	regress Salary Ed
end
simulate _b _se, reps(50):  OSL_SIM
list _b_* _se*
summarize _b*

clear all
program OSL_SIM
	clear
	set obs 100
	gen Ed = 16*runiform()
	scalar SD = 10000
	gen Salary = 12000 + 1000*Ed + SD*rnormal()
	regress Salary Ed
end
simulate _b _se, reps(500):  OSL_SIM
list _b_* _se*
summarize _b*
 kdensity _b_Ed





log close