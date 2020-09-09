qui cd "D:\Studium\01_Oldenburg\Lehre\Datensaetze"
qui use  "Allbus_1980-2018.dta",clear
qui keep if year == 1990
qui mvdecode educ, mv(-9 6 7)
qui mvdecode mi02, mv(-9 -8 -7)
spearman educ mi02
