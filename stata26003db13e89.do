set linesize 200
qui use  "D:/oCloud/Home-Cloud/Lehre/Methodenseminar/Allbus_1980-2018.dta"
qui keep if year == 2014 & sex ==  1 & hs16 > 0
set seed 1212
bootstrap r(mean), reps(2000): summarize hs16
