set linesize 80
qui use "D:\oCloud\Home-Cloud\Lehre\Methodenseminar\Allbus2018.dta", clear
qui egen age_cat = cut(age), at( 18 35 60 100 ) 
label define age_cat_lab 18 "18-34 Jahre" 35 "35-29 Jahre" 60 "über 60 Jahre" 
label values age_cat age_cat_lab
tab age_cat
