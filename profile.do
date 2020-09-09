        set logtype text
        set type double
use "regression_bsp.dta", clear
egen mean_var2 = mean(var2)
gen m_abw = var2 - mean_var2
qui reg var2 var1
predict pred_vorher, xb
gen res = var2 - pred_vorher 
gen res2 = res^2
set linesize 90
reg var2 var1
