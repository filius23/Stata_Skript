use "regression_bsp.dta", clear
egen mean_var2 = mean(var2)
gen m_abw = var2 - mean_var2
qui reg var2 var1
predict pred_vorher, xb
gen res = var2 - pred_vorher 
gen res2 = res^2
set linesize 90
reg var2 var1
use "regression_bsp.dta", clear
egen mean_var2 = mean(var2)
gen m_abw = var2 - mean_var2
qui reg var2 var1
predict pred_vorher, xb
gen res = var2 - pred_vorher 
gen res2 = res^2
set linesize 90
reg var2 var1
use "regression_bsp.dta", clear
egen mean_var2 = mean(var2)
gen m_abw = var2 - mean_var2
qui reg var2 var1
predict pred_vorher, xb
gen res = var2 - pred_vorher 
gen res2 = res^2
set linesize 90
reg var2 var1
use "regression_bsp.dta", clear
egen mean_var2 = mean(var2)
gen m_abw = var2 - mean_var2
qui reg var2 var1
predict pred_vorher, xb
gen res = var2 - pred_vorher 
gen res2 = res^2
set linesize 90
reg var2 var1
dis 7.5625+0.5625+5.0625+1.5625 // abw2 aus Mittelwertsregel
dis 0.5129657+0.4937911+0.6356830+0.6143170 // res2 aus regressionsmodell
dis 14.75 -  2.256757
reg var2 var1
