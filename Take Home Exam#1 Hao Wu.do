/*
This program is for ECO 480 Take Home Exam#1 
Last modified by:Hao Wu
Last modified on: Feb 23, 2021
*/
clear all
cd "D:\stata\ECO 480"

set more off
capture log close
log using Take_Home_Exam#1_Hao_Wu2.log, replace

putdocx begin
putdocx paragraph, halign(center)
putdocx text ("Take Home Exam#1 Word File"), bold linebreak
putdocx paragraph
putdocx text ("For this exam, I make the following truthful statements:"), bold linebreak
putdocx text ("	1. I have not received any non-instructor approved assistance, I have not given any noninstructor approved assistance to another student taking this exam, including discussing the exam with students in another section of the course."), bold linebreak
putdocx text ("	2. I did not plagiarize someone else’s work and turn it in as my own"), bold linebreak
putdocx text ("	3. I understand that acts of academic dishonesty may be penalized to the full extent allowed by the University at Buffalo Student Conduct Code, including receiving a failing grade for the course with a transcript notation and being expelled from the university. I recognize that I am responsible for understanding the provisions of the University at Buffalo Student Conduct Code as they relate to this academic exercise."), bold linebreak
putdocx text ("Name:")
putdocx text ("     Hao Wu     "), underline
putdocx text ("Sign:")
putdocx text ("     Hao Wu     "), underline italic
putdocx text ("Date:")
putdocx text (" 02/22/2021"), underline
use donut, clear
putdocx paragraph, 
putdocx text ("Question 1a"), linebreak
putdocx text ("First of all we need get Summary the dataset type and review missing value")
misstable summarize
sum
graph box weightx childx malex
graph export box_weight_childx_malex.png,replace
putdocx paragraph, halign(center)
putdocx image box_weight_childx_malex.png
putdocx text ("This dataset has 4 variable labels 'dounuts','weight','child','male'. Variables donuts' type is str, it should be float. After checking the list of donuts table find out a str value 'five'. We need to replace 'five' to 5, and change variable donuts type to float. Then from the box plot, we regonise the weight of Patty doesn't make sense. Through review variable child, we know it is indicate variable, it should be int and equal to 0 or 1. We need to replace -1 to 1. we create new variable to change value")

gen donutsx2 = real(donutsx)
gen weightx2 =weightx
gen childx2  = childx
gen malex2   = malex
replace donutsx2 = 5 in 12
replace weightx2 = 155 in 12
replace childx2 = 1 if childx2 < 0
list
putdocx paragraph
putdocx text ("Question 1b"),linebreak
regress donutsx2 weightx2
putdocx table reg_donut_weight = etable
predict yhat, xb
predict residual, residual



**Question2
use winter_olympics, clear
*a.panel dataset
putdocx paragraph
putdocx text ("Question 2a"),linebreak
tab year
putdocx text ("It is panel dataset, because it used different countries over time.")
*b
sum(medal athlete GDP)
*c we have been know the oder of the year, so that we could the first five year as fiter(>1994)
bysort country year: sum(country)
bysort country: gen Num_country_repeat=_n
drop if Num_country_repeat > 5
*d
bysort year: sum(year)
putdocx paragraph 
putdocx text ("Question 2d"), linebreak
putdocx text ("In 1980s,1984s, 1988s,there have 117 observations; In 1992s, there have 113 obervations; In 1994s, there have 110 observations")
*e
bysort host: sum(host)
bysort host year: tabulate country
putdocx paragraph 
putdocx text ("Question 2e"), linebreak
putdocx text ("There have 5 country have hosted the Winter Olympics, each of them hose 1 time. United States hosted in 1980, Yugoslavia hosted in 1984, Canada hosted in 1988, France hosted in 1992, Norway hosted in 1994")
*f 
putdocx paragraph 
putdocx text ("Question 2f"), linebreak
scatter medals athletes || lfit medals athletes
graph export reg_scat_medals_athlets.png, replace
putdocx image reg_scat_medals_athlets.png
putdocx paragraph
putdocx text ("From the graph we could know when the number of athletes is less than 50, the number of medals will not be much. But when the number of athletes is greater than 50, the probability of winning more than 10 medals increases. Generally, the realationship bewtween medals and athletes is positve")

*g 
putdocx paragraph 
putdocx text ("Question 2g"), linebreak
regress medals athletes
putdocx table reg_medals_althletes = etable
putdocx paragraph
putdocx text ("We could easier get conclusion from table which above this paragraph, the coef is positive and P value is 0, so that there have sufficient evidence that having more athletes cases the medal cout to go up")

*h
putdocx paragraph 
putdocx text ("Question 2h"), linebreak
scatter medals GDP || lfit medals GDP
graph export reg_scat_medals_GDP.png, replace
putdocx paragraph
putdocx image reg_scat_medals_GDP.png
regress medals GDP
putdocx table reg_medals_GDP = etable 
putdocx paragraph
putdocx text ("The hypothesis of H0 is: all predictors will not affect y, that is, the coef of all predictors will be 0, and all predictors will not be significant. The value of Prob>F is the probability of the establishment of the above-mentioned H0 hypothesis. When it approaches 0, it means that at least some predictors’ coef is not 0.")

*i
putdocx paragraph 
putdocx text ("Question 2i"), linebreak
scatter medals population || lfit medals population
graph export reg_scat_medals_population.png, replace
putdocx paragraph
putdocx image reg_scat_medals_population.png
regress medals population
putdocx table reg_medals_population = etable 
putdocx paragraph
putdocx text ("only when p value approch to 0, we have effident to reject H0, after we run the regression, we know p value is 0.7467, significant larger than 0, so that we cant reject the slope coefficient."), linebreak

*j
putdocx paragraph
putdocx text  ("Question 2j"), linebreak
scatter medals temp || lfit medals temp
graph export reg_scat_medals_temp.png, replace
putdocx paragraph
putdocx image reg_scat_medals_temp.png
regress medals temp, level(93)
putdocx table reg_medals_temp = etable
putdocx paragraph
putdocx text ("The conef is - 0.0448618. The P-value is 0 less than 0.07, so that we should reject H0. The variance have statistic significant. The confident interval is -0.0575173 to -0.0322064")

*Question 3
use height_wages, clear
putdocx paragraph 
putdocx text ("Question 3a"), linebreak
*a 
summarize wage96 height85 height81 siblings
putdocx paragraph
putdocx text ("When we got large sample dataset, we could use mean of each variable to replace the missing value")

*b 
putdocx paragraph 
putdocx text ("Question 3b"), linebreak
scatter wage96 height85 
putdocx paragraph
graph export sca_wage96_height85.png, replace
putdocx image sca_wage96_height85.png, linebreak
putdocx text ("We can see that there are three noise point belonging to the outline value, but because our sample is large, it will not affect our next behavior.")

*c
putdocx paragraph 
putdocx text ("Question 3c"), linebreak
twoway scatter wage96 height85 if wage96 <= 500
putdocx paragraph
graph export sca_wage96_height85_below500.png,replace
putdocx image sca_wage96_height85_below500.png, linebreak
putdocx text ("These data show a normal distribution trend, and most of the values are concentrated in 60-75")

*d
putdocx paragraph 
putdocx text ("Question 3d"), linebreak
twoway scatter height81 height85 if height81 > height85
putdocx paragraph
regress height81 height85 if height81 > height85
graph export sca_height81_height85_.png, replace
putdocx image sca_height81_height85_.png, linebreak
putdocx text ("Is not statistically significant, so we don’t use")
*e 
putdocx paragraph 
putdocx text ("Question 3e"), linebreak
bysort male: egen height_ave= mean(height85)
ta male height_ave 
tab(height_ave)
gen tall = 0 
replace tall = 1 if male == 0 & height85 > 64.23
replace tall = 1 if male == 1 & height85 > 70.01
replace tall = . if missing(height85)
bysort male : sum(tall)
putdocx text ("We need to calculate the average of the samples by gender, and then classify whether they belong to the label of tall according to gender. All missing values are represented by "."")

*f
putdocx paragraph 
putdocx text ("Question 3f"), linebreak
regress wage96 tall if male == 0
putdocx table wage_notall = etable
regress wage96 tall if male == 1
putdocx table wage_tall = etable
putdocx paragraph
putdocx text ("P values are all greater than 0.05, so there is no statistical significance, not reject H0.")

*g
putdocx paragraph 
putdocx text ("Question 3g"), linebreak
regress wage96 tall if male == 0 & wage96 <= 500
putdocx table wage_notall_less500 = etable
regress wage96 tall if male == 1 & wage96 <= 500
putdocx table wage_tall_less500 = etable
putdocx paragraph
putdocx text ("All P values tend to be close to 0, so there is significant statistical significance, reject H0.")
*Question 4
use anscombe, clear
putdocx paragraph
putdocx text ("Question 4a"), linebreak
*a 
sum(),detail
putdocx paragraph
putdocx text ("All X have same mean and variance, all Y also have same mean and variance.")
*b 
putdocx paragraph
putdocx text ("Question 4b"), linebreak
scatter y1 x1
graph export x1_y1.png, replace
scatter y2 x2 
graph export x2_y2.png, replace
scatter y3 x3
graph export x3_y3.png, replace
scatter y4 x4
graph export x4_y4.png, replace
putdocx image x1_y1.png
putdocx image x2_y2.png
putdocx image x3_y3.png
putdocx image x4_y4.png
*c
putdocx paragraph
putdocx text ("Question 4c"), linebreak
putdocx text ("The first is a positive correlation, the second is a normal distribution, the third is a linear positive correlation, and the fourth two variables are independent")

log close
putdocx save Take_home_exam#1_wordfile.docx, replace


