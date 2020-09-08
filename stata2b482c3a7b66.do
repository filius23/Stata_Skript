set linesize 80
qui use "D:\oCloud\Home-Cloud\Lehre\Methodenseminar\Allbus2018.dta", clear
qui egen age_cat = cut(age), at( 18 35 60 100 ) 
tabulate age_cat
